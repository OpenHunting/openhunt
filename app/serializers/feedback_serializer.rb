# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  anonymous  :boolean          default(FALSE)
#  project_id :integer          not null
#  user_id    :integer
#  session_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :project_id, :body, :anonymous, :created_at, :updated_at

end
