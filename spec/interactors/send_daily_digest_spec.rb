require 'rails_helper'

RSpec.describe SendDailyDigest do
  let(:submitter) {FactoryGirl.create(:user)}
  let(:project) { submitter.projects.create(FactoryGirl.attributes_for(:project,  bucket: "20151214")) }
  let(:contents) { [] }
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

  it "gets recipients" do
    digest
    submitter
    result = SendDailyDigest.call
    expect(result.recipients.first).to eql submitter
  end
end
