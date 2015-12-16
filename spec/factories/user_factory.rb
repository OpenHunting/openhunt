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
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :user do
     screen_name "asdf"
     name "asdf"
     profile_image_url "asdf"
     twitter_id "asdf"
     location "asdf"
  end
end
