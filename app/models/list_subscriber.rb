# == Schema Information
#
# Table name: list_subscribers
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  subscribed :boolean          default(TRUE)
#  user_id    :uuid(16)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ListSubscriber < ActiveRecord::Base

  # optional user_id
  belongs_to :user

  validates_presence_of :email

end
