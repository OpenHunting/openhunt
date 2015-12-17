# == Schema Information
#
# Table name: users
#
#  id                :uuid(16)         primary key
#  screen_name       :string           not null
#  name              :string
#  profile_image_url :string
#  twitter_id        :string
#  location          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_screen_name  (screen_name)
#  sqlite_autoindex_users_1    (id) UNIQUE
#

FactoryGirl.define do
  factory :user do
    sequence :screen_name do |n|
      "asdf#{n}"
    end
    name "asdf"
    profile_image_url "asdf"
    twitter_id "asdf"
 location "asdf"
  end
end
