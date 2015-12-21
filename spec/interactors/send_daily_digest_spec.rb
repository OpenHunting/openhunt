require 'rails_helper'

RSpec.describe SendDailyDigest do
  let(:submitter) {FactoryGirl.create(:user)}
  let(:list_subscriber) { submitter.create_list_subscriber(email: "test@test.com") }
  let(:project) { submitter.projects.create(FactoryGirl.attributes_for(:project,  bucket: "20151214")) }
  let(:contents) {
    { "projects" => [ project ] }
  }
  let(:digest) { DailyDigest.create(
    sent: false,
    contents: contents,
    bucket: Project.bucket(Time.now - 1.day)
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
    result = SendDailyDigest.call
    expect(result.digest).to eql digest
  end

  it "excludes sent digest" do
    digest.update_attributes(sent: true)
    result = SendDailyDigest.call
    expect(result.success?).to be false
  end

  it "sends emails recipients" do
    ActionMailer::Base.deliveries = []
    digest
    list_subscriber
    SendDailyDigest.call
    expect(ActionMailer::Base.deliveries.count).to eql 1
  end
end
