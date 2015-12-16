class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :url, :votes_count, :created_at

  # TODO: user
end
