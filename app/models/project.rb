# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  description     :string           not null
#  url             :string           not null
#  normalized_url  :string           not null
#  bucket          :string           not null
#  slug            :string           not null
#  user_id         :integer          not null
#  hidden          :boolean          default(FALSE)
#  votes_count     :integer          default(0)
#  feedbacks_count :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_projects_on_bucket  (bucket)
#  index_projects_on_slug    (slug)
#

class Project < ActiveRecord::Base
  belongs_to :user

  has_many :votes
  has_many :feedbacks

  before_save :normalize_url
  def normalize_url
    self.normalized_url = self.class.normalize_url(self.url)
  end

  def self.visible
    where(hidden: false)
  end

  before_create :set_slug
  def set_slug
    if self.name.present?
      self.slug = name.parameterize
    end
  end

  before_save :set_bucket
  def set_bucket
    self.bucket ||= self.class.bucket(Time.find_zone!(Settings.base_timezone).now)
  end

  def self.normalize_url(url)
    url = url.to_s
    url = url.gsub(/\\/,'')
    url = url.gsub("http://", "").gsub("https://", "")

    # remove trailing slash (if it doesn't have query params)
    url = url[0...-1] if url.ends_with?("/") and !url.include?("?")

    # TODO: remove url junk like UTM, etc

    url
  end

  # www.example.com
  # example.com <= duplicate! do not allow!
  def self.get_duplicate_by_url(url)
    normalized_url = Project.normalize_url(url)
    normalized_url = slice_www(normalized_url)
    Project.where("normalized_url ~* ?", normalized_url).first
  end

  def self.slice_www(normalized_url)
    if normalized_url[0..3] == "www."
      normalized_url = normalized_url.slice(4, normalized_url.length)
    end
    normalized_url
  end

  def self.duplicate_exists?(url)
    get_duplicate_by_url(url).present?
  end


  def self.for_bucket(bucket)
    Project.visible.where(bucket: bucket).order(:votes_count => :desc)
  end

  def self.recent
    Project.visible.order(created_at: :desc).limit(25)
  end

  # Discussing HackerNews algorithm:
  # https://medium.com/hacking-and-gonzo/how-hacker-news-ranking-algorithm-works-1d9b0cf2c08d#.bkaj2mpm1
  # Here is the older, simpler algorithm
  def score
    # NOTE: if the code changes, so that a submitter automatically
    # creates a vote for his submission, then we will want to
    # subtract that vote before calculating the score:
    # votes = votes_count - 1
    votes = votes_count
    hours_since_submission = (Time.now.hour - created_at.hour).abs
    gravity = 1.8 # gravity defaults to 1.8 in news.arc

    votes / (hours_since_submission + 2) ** gravity
  end

  def self.bucket(time)
    time = parse_bucket(time) if time.is_a?(String)

    if time.wday == 6 # saturday
      bucket(time + 1.day)
    else
      return time.strftime("%Y%m%d")
    end
  end

  def self.parse_bucket(bucket_key)
    year, month, date = bucket_key[0...4], bucket_key[4...6], bucket_key[6...8]
    return nil unless year.present? and month.present? and date.present?

    Time.find_zone!(Settings.base_timezone).parse("#{year}-#{month}-#{date}").at_midnight
  end

  def self.next_bucket(time)
    time = parse_bucket(time) if time.is_a?(String)

    current_now = Time.find_zone!(Settings.base_timezone).now.at_midnight
    next_day = time + 1.day
    next_day += 1.day if time.wday == 6
    if (next_day).at_midnight > current_now
      nil
    else
      bucket(next_day)
    end
  end

  def self.prev_bucket(time)
    time = parse_bucket(time) if time.is_a?(String)

    return bucket(time-2.days) if time.wday == 0
    return bucket(time-1.days)
  end

  def self.is_bucket_today?(time)
    time = parse_bucket(time) if time.is_a?(String)

    time.at_midnight == Time.find_zone!(Settings.base_timezone).now.at_midnight
  end
  # check if the time is before the site launched
  def self.end_of_buckets?(time)
    time = parse_bucket(time) if time.is_a?(String)

    if Settings.site_launch
      launch_time = Time.find_zone!(Settings.base_timezone).parse(Settings.site_launch).at_midnight
      time < launch_time
    else
      false
    end
  end
end
