# == Schema Information
#
# Table name: audit_logs
#
#  id           :integer          not null, primary key
#  moderator_id :integer
#  item_type    :string
#  target_id    :integer
#  target_type  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AuditLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :project


end
