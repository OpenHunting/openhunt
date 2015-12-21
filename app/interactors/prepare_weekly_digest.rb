class PrepareWeeklyDigest < BaseInteractor

  def call
    context.digest = WeeklyDigest.new(
      sent: false,
      contents: {
        "buckets" => []
      },
      bucket_range: ""
    )

    context.buckets = get_buckets
    context.digest.bucket_range = get_bucket_range
    check_for_existing_digest!
    set_digest_contents
    
    if context.digest.save!
      return context
    else
      raise "Could not save digest for bucket #{context.digest.bucket}"
    end
  end

  def get_buckets
    time = Time.find_zone!(Settings.base_timezone).now
    buckets = []
    7.times do |i|
      buckets << Project.prev_bucket(time - i.days)
    end
    buckets.uniq.sort
  end

  def get_bucket_range
    context.buckets.first + " " + context.buckets.last
  end

  def check_for_existing_digest!
    if WeeklyDigest.where(bucket_range: context.digest.bucket_range).count > 0
      context.fail! message: "Digest already exists for bucket #{context.digest.bucket_range}"
    end
  end

  def set_digest_contents
    context.buckets.each do |bucket|
      context.digest.contents["buckets"] << data_for_bucket(bucket)
    end
  end

  def data_for_bucket(bucket)
    bucket_data = {}
    bucket_data["bucket"] = bucket
    bucket_data["projects"] = []
    Project.for_bucket(bucket).each { |project| bucket_data["projects"] << project }
    bucket_data
  end
end
