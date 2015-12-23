# == Schema Information
#
# Table name: list_subscribers
#
#  id           :integer          not null, primary key
#  email        :string           not null
#  subscribed   :boolean          default(TRUE)
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  confirmed    :boolean          default(FALSE)
#  confirm_code :string
#  email_format :string
#

class ListSubscriber < ActiveRecord::Base

  # optional user_id
  belongs_to :user

  validates_presence_of :email
  validates_email :email, :allow_blank => true
  validates_uniqueness_of :email, :on => :create, :message => "is already taken"

end
