class DigestMailer < ApplicationMailer

  def daily_email(subscriber, digest)
    @subscriber = subscriber
    @projects = digest.contents["projects"]

    mail(to: @subscriber.email, subject: "OpenHunt Daily Digest #{digest.bucket}")
  end

  def weekly_email(subscriber, digest)
    @subscriber = subscriber
    @buckets = digest.contents["buckets"]

    mail(to: @subscriber.email, subject: "OpenHunt Daily Digest #{digest.bucket_range}")
  end
end
