# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  description    :string           not null
#  url            :string           not null
#  normalized_url :string           not null
#  bucket         :string           not null
#  user_id        :integer          not null
#  votes_count    :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Project < ActiveRecord::Base
  belongs_to :user

  has_many :votes

  before_save :normalize_url
  def normalize_url
    self.normalized_url = self.class.normalize_url(self.url)
  end

  before_save :set_bucket
  def set_bucket
    self.bucket = self.class.bucket(Time.find_zone!(Settings.base_timezone).now)
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


  def self.for_bucket(bucket)
    Project.all.where(bucket: bucket).order(:votes_count => :desc)
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
    case time.wday
    when 0 # sunday
      saturday = (time - 1.day).strftime("%Y%m%d")
      sunday = time.strftime("%Y%m%d")
      return "#{sunday}"
    when 6 # saturday
      saturday = time.strftime("%Y%m%d")
      sunday = (time + 1.day).strftime("%Y%m%d")
      return "#{sunday}"
    else
      return time.strftime("%Y%m%d")
    end
  end
end
