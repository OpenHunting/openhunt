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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe AuditLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
