class PrepareDailyDigest < BaseInteractor

  def call
    context.digest = DailyDigest.new(
      sent: false,
      contents: [],
      bucket: get_bucket
    )

    check_for_existing_digest
    gather_projects
    set_digest_contents

    if context.digest.save!
      return context
    else
      raise "Could not save digest for bucket #{context.digest.bucket}"
    end
  end

  def get_bucket
    time = Time.find_zone!(Settings.base_timezone).now
    Project.prev_bucket(time)
  end

  def check_for_existing_digest
    if DailyDigest.where(bucket: context.digest.bucket).count > 0
      context.fail! message: "Digest already exists for bucket #{context.digest.bucket}"
    end
  end

  def gather_projects
    context.projects = Project.for_bucket(context.digest.bucket)
  end

  def set_digest_contents
    context.projects.each do |project|
      context.digest.contents.push(project)
    end
  end
end
