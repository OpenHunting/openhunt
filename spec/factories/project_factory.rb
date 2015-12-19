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

FactoryGirl.define do
  factory :project do
     name "asdf"
     description "asdfasdf"
     url "http://www.asdf.com"
    # association :user, factory: :user
  end
end
