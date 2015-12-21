# == Schema Information
#
# Table name: feedbacks
#
#  id             :integer          not null, primary key
#  body           :text             not null
#  anonymous      :boolean          default(FALSE)
#  project_id     :integer          not null
#  user_id        :integer
#  anon_user_hash :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Feedback < ActiveRecord::Base
  belongs_to :project, counter_cache: true
  belongs_to :user

  validates_presence_of :body, :message => "can't be blank"
end
