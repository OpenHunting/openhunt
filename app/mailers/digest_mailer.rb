class DigestMailer < ApplicationMailer

  def daily_email(subscriber, digest)
    @subscriber = subscriber
    @projects = digest.contents["projects"]

    mail(to: @subscriber.email, subject: "OpenHunt Daily Digest #{digest.bucket}")
  end
end
