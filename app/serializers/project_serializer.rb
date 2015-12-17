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

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :slug, :name, :description, :url, :votes_count, :feedbacks_count, :created_at, :user_id

  # TODO: user
end
