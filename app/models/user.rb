# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  screen_name       :string           not null
#  name              :string
#  profile_image_url :string
#  twitter_id        :string
#  location          :string
#  email             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class User < ActiveRecord::Base
  has_many :votes
  has_many :projects
    
end
