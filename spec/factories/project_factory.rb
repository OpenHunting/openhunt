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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :project do
     name "Asdf"
     description "asdfasdf"
     url "asdf"
    # association :user, factory: :user
  end
end
