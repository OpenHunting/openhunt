require 'rails_helper'

RSpec.describe PrepareWeeklyDigest do
  let(:submitter) {FactoryGirl.create(:user)}
  before :each do
    DatabaseCleaner.clean
    Timecop.freeze(Time.local(2015,12,15, 9))
    10.times do |i|
      bucket = Project.bucket(Time.now - i.days)
      submitter.projects.create(
        FactoryGirl.attributes_for(:project,
          bucket: bucket
        )
      )
    end
  end
  after :each do
    Timecop.return
  end

  it "gathers the correct buckets" do
    #  20151215 is a Tuesday
    #  buckets: 20151208 20151209 20151210 20151211 20151213 20151214
    result = PrepareWeeklyDigest.call
    expect(result.digest.bucket_range).to eql "20151208 20151214"
  end

  it "gets projects for each bucket" do
    result = PrepareWeeklyDigest.call
    expect(result.digest.contents["buckets"][0]["projects"][0].bucket).to eql "20151208"
    expect(result.digest.contents["buckets"][5]["projects"][0].bucket).to eql "20151214"
  end

  it "checks if digest already exists" do
    PrepareWeeklyDigest.call
    PrepareWeeklyDigest.call
    expect(WeeklyDigest.count).to eql 1
  end

  it "sent defaults to false" do
    PrepareWeeklyDigest.call
    expect(WeeklyDigest.first.sent).to eql false
  end

end
