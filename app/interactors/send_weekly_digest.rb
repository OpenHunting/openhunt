class SendWeeklyDigest < BaseInteractor

  def call
    context.bucket_range = identify_bucket_range
    context.digest = get_digest_by_bucket_range
    fail_if_found_none
    send_to_subscribers
    set_sent_to_true!
  end

  def identify_bucket_range
    time = Time.find_zone!(Settings.base_timezone).now
    buckets = []
    7.times do |i|
      buckets << Project.prev_bucket(time - i.days)
    end
    buckets = buckets.uniq.sort
    buckets.first + " " + buckets.last
  end

  def get_digest_by_bucket_range
    WeeklyDigest.where(bucket_range: context.bucket_range, sent: false).first
  end

  def fail_if_found_none
    context.fail!(message: "Did not find any unsent digest") if context.digest.blank?
  end

  def send_to_subscribers
    ListSubscriber.where(
      subscribed: true,
      weekly: true
    ).find_each do |subscriber|
      # TODO: deliver_later using ActiveJob & resque
      DigestMailer.weekly_email(subscriber, context.digest).deliver_now
      # QUESTION: should we store the digest id into 'subscriber.sent_digests'
      # to help ensure we never send the same digest to the same subsciber twice?
    end
  end

  def set_sent_to_true!
    context.digest.update_attributes!(sent: true)
  end
end
