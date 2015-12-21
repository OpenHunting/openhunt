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

require 'rails_helper'

RSpec.describe DailyDigest, type: :model do
  it "calls PrepareDailyDigest" do
    mock_result = OpenStruct.new(success?: true)
    expect(PrepareDailyDigest).to receive(:call).and_return(mock_result)
    DailyDigest.prepare!
  end
end
