# == Schema Information
#
# Table name: daily_digests
#
#  id         :integer          not null, primary key
#  sent       :boolean
#  bucket     :string
#  contents   :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DailyDigest < ActiveRecord::Base
  def self.prepare!
    PrepareDailyDigest.call()
  end
end
