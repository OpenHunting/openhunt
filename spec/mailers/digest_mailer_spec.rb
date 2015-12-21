require "rails_helper"

RSpec.describe DigestMailer, type: :mailer do

  let(:deliveries) { ActionMailer::Base.deliveries }
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
    ActionMailer::Base.deliveries = []
    DatabaseCleaner.clean
    Timecop.freeze(Time.local(2015,12,15, 9))
    digest
  end
  after :each do
    Timecop.return
  end

  it "sends one email" do
    expect {
      DigestMailer.daily_email(list_subscriber, digest).deliver
    }.to change { deliveries.count }.by 1
  end

  it "shows the digest bucket date" do
    DigestMailer.daily_email(list_subscriber, digest).deliver
    expect(deliveries.first.body).to include "OpenHunt Daily Digest"
    expect(deliveries.first.body).to include project.name
    expect(deliveries.first.body).to include project.url
    expect(deliveries.first.body).to include project.description
  end
end
