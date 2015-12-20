require "rails_helper"
#
RSpec.describe "Projects", :type => :request do
  context "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { user.projects.create(FactoryGirl.attributes_for(:project))}
    let(:log) { AuditLog.create(
       item_type: "update_project",
       target_id: project.id,
       target_type: "Project",
       target_display: project.name,
       target_url: "/feedback/#{project.slug}"
      ) }
    before :each do
      DatabaseCleaner.clean
      ApplicationController.any_instance.stub(:current_user).and_return(user)
    end
    it "loads form" do
      log
      get "/audit/#{log.id}/edit"
      expect(response.body.present?).to eql true
    end
  end

  context "update" do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { user.projects.create(FactoryGirl.attributes_for(:project))}
    before :each do
      DatabaseCleaner.clean
      ApplicationController.any_instance.stub(:current_user).and_return(user)
    end
  end
end
