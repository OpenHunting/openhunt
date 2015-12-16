# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  description    :string           not null
#  url            :string           not null
#  normalized_url :string           not null
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

  def self.normalize_url(url)
    url = url.to_s
    url = url.gsub(/\\/,'')
    url = url.gsub("http://", "").gsub("https://", "")

    # remove trailing slash (if it doesn't have query params)
    url = url[0...-1] if url.ends_with?("/") and !url.include?("?")

    # TODO: remove url junk like UTM, etc

    url
  end


  def self.featured(page = nil, per_page = nil)
    page ||= 1
    per_page ||= Settings.featured_per_page

    # TODO: sort projects by ranking

    # calculate offset
    offset = (page - 1)*per_page
    offset = 0 if offset <= 0

    Project.all.order(:created_at => :desc).limit(per_page).offset(offset)

  end
end
