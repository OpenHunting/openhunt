require 'rails_helper'

RSpec.describe PrepareDailyDigest do
  let(:submitter) {FactoryGirl.create(:user)}
  let(:project) { submitter.projects.create(FactoryGirl.attributes_for(:project,  bucket: "20151214")) }
  before :each do
    DatabaseCleaner.clean
    Timecop.freeze(Time.local(2015,12,15, 9))
  end
  after :each do
    Timecop.return
  end

  it "checks if digest already exists" do
    PrepareDailyDigest.call
    PrepareDailyDigest.call
    expect(DailyDigest.count).to eql 1
  end

  it "creates a digest" do
    project
    PrepareDailyDigest.call
    digest = DailyDigest.first
    expect(digest.bucket).to eql "20151214"
    expect(digest.sent).to eql false
    expect(digest.contents.first["name"]).to eql "asdf"
  end

end
