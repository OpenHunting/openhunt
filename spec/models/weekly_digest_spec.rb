# == Schema Information
#
# Table name: weekly_digests
#
#  id           :integer          not null, primary key
#  sent         :boolean
#  bucket_range :string
#  contents     :json
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe WeeklyDigest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
