require "rails_helper"
#
RSpec.describe "Projects", :type => :request do
  context "projects index" do
    before do
      # headers = {
      #   "ACCEPT" => "application/json",     # This is what Rails 4 accepts
      # }
      get("/", {}, headers)
    end

    it "should return with proper http" do
      expect(response).to have_http_status(200)
    end
  end

  context "create project" do
    let(:user) { FactoryGirl.create(:user) }
    let(:params) { {
      name: 'asdf',
      url: 'http://www.asdf.com',
      description: 'asdf'
    } }
    before :each do
      DatabaseCleaner.clean
      ApplicationController.any_instance.stub(:current_user).and_return(user)
    end
    it "creates a new project" do
      post("/new", params)
      expect(Project.first.name).to eql 'asdf'
      expect(Project.first.votes_count).to eql 1
      expect(Project.first.votes.first.user_id).to eql user.id
    end
    it "detects a duplicate submission by 'www'" do
      post("/new", params)
      user2 = FactoryGirl.create(:user)
      ApplicationController.any_instance.stub(:current_user).and_return(user2)
      params["name"] = 'asdf banana'
      params["url"] = 'http://asdf.com'
      post("/new", params)
      expect(Project.count).to eql 1
    end
  end
end
