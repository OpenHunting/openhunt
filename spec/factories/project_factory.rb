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

FactoryGirl.define do
  factory :project do
     name "asdf"
     description "asdfasdf"
     url "asd"
    # association :user, factory: :user
  end
end
