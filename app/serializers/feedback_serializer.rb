class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :project_id, :body, :anonymous, :created_at, :updated_at

end
