class DigestMailer < ApplicationMailer

  # TODO: does user need ability to choose between text & html emails?
  # or can we send multipart emails and just let his email client decide?
  # (currently, the user can choose in /settings)

  def daily_email(subscriber, digest)
    @subscriber = subscriber
    @projects = digest.contents["projects"]
    @bucket = digest.bucket

    mail(to: @subscriber.email, subject: "OpenHunt Daily Digest #{@bucket}")
  end

  def weekly_email(subscriber, digest)
    @subscriber = subscriber
    @buckets = digest.contents["buckets"]
    @bucket_range = digest.bucket_range

    mail(to: @subscriber.email, subject: "OpenHunt Daily Digest #{@bucket_range}")
  end
end
