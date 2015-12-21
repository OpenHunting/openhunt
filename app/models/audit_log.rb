# == Schema Information
#
# Table name: audit_logs
#
#  id             :integer          not null, primary key
#  moderator_id   :integer
#  item_type      :string
#  target_id      :integer
#  target_type    :string
#  target_display :string
#  target_url     :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  note           :string
#

class AuditLog < ActiveRecord::Base
  belongs_to :moderator, class_name: "User"
  belongs_to :project


end
