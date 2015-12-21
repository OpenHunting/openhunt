require "rails_helper"

RSpec.describe "Projects", :type => :request do
  let(:user) { FactoryGirl.create(:user, moderator: true) }
  let(:project) { user.projects.create(FactoryGirl.attributes_for(:project))}
  let(:log) { AuditLog.create(
    moderator_id: user.id,
    item_type: "update_project",
    target_id: project.id,
    target_type: "Project",
    target_display: project.name,
    target_url: "/detail/#{project.slug}"
  ) }

  before :each do
    DatabaseCleaner.clean
    ApplicationController.any_instance.stub(:current_user).and_return(user)
  end

  context "edit" do
    it "loads form" do
      get "/audit/#{log.id}/edit"
      expect(response.body).to include "Note"
    end
  end

  context "update" do
    it "updates the log with the note" do
      patch "/audit/#{log.id}", note: "testtesttest"
      follow_redirect!
      expect(response.body).to include "testtesttest"
      expect(AuditLog.first.note).to eql "testtesttest"
    end
  end
end
