require "rails_helper"
#
RSpec.describe "Users", :type => :request do

  context "add moderator" do
    let(:user) { FactoryGirl.create(:user, moderator: true) }
    let(:user2) { FactoryGirl.create(:user) }
    before :each do
      DatabaseCleaner.clean
      ApplicationController.any_instance.stub(:current_user).and_return(user)
    end
    it "make_moderator" do
      post("/make_moderator/@#{user2.screen_name}")
      expect(user2.reload.moderator).to eql true
    end

    it "remove_moderator" do
      user2.update_attributes!(moderator: true)
      post("/remove_moderator/@#{user2.screen_name}")
      expect(user2.reload.moderator).to eql false
    end
  end
end
