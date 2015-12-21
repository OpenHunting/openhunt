require 'rails_helper'

RSpec.describe SendWeeklyDigest do
  let(:submitter) {FactoryGirl.create(:user)}
  let(:list_subscriber) { submitter.create_list_subscriber(
    email: "test@test.com",
    weekly: true)
  }
  let(:project) { submitter.projects.create(FactoryGirl.attributes_for(:project,  bucket: "20151214")) }
  let(:contents) {
    { "buckets" => [
        { "bucket" => "20151208", "projects" => [project] }
      ]
    }
  }
  let(:digest) { WeeklyDigest.create(
    sent: false,
    contents: contents,
    bucket_range: "20151208 20151214"
  )}
  before :each do
    DatabaseCleaner.clean
    Timecop.freeze(Time.local(2015,12,15, 9))
  end
  after :each do
    Timecop.return
  end

  it "gets digest for correct (previous) bucket" do
    digest
    result = SendWeeklyDigest.call
    expect(result.digest).to eql digest
  end

  it "excludes sent digest" do
    digest.update_attributes(sent: true)
    result = SendWeeklyDigest.call
    expect(result.success?).to be false
  end

  it "sends emails recipients" do # <= this is like a full integration test
    ActionMailer::Base.deliveries = []
    digest
    list_subscriber
    SendWeeklyDigest.call
    expect(ActionMailer::Base.deliveries.count).to eql 1
  end
end
