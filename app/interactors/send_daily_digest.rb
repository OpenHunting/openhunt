class SendDailyDigest < BaseInteractor

  def call
    context.bucket = identify_bucket
    context.digest = get_digest_by_bucket
  end

  def identify_bucket
    Project.bucket(Time.now - 1.day)
  end

  def get_digest_by_bucket
    DailyDigest.where(bucket: context.bucket).first
  end
end
