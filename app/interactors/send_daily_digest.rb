class SendDailyDigest < BaseInteractor

  def call
    context.bucket = identify_bucket
    context.digest = get_digest_by_bucket
    fail_if_found_none
    send_to_subscribers
    set_sent_to_true!
  end

  def identify_bucket
    Project.bucket(Time.now - 1.day)
  end

  def get_digest_by_bucket
    DailyDigest.where(bucket: context.bucket, sent: false).first
  end

  def fail_if_found_none
    context.fail!(message: "Did not find any unsent digest") if context.digest.blank?
  end

  def send_to_subscribers
    ListSubscriber.where(
      subscribed: true
      # daily: true  # <= TODO: we will have daily and weekly digests
    ).find_each do |subscriber|
      # TODO: deliver_later using ActiveJob & resque
      DigestMailer.daily_email(subscriber, context.digest).deliver_now
      # QUESTION: should we store the digest id into 'subscriber.sent_digests'
      # to help ensure we never send the same digest to the same subsciber twice?
    end
  end

  def set_sent_to_true!
    context.digest.update_attributes!(sent: true)
  end

end
