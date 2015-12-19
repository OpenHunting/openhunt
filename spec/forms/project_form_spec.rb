
require 'rails_helper'

RSpec.describe ProjectForm do
  let(:submitter) { FactoryGirl.create(:user) }
  let(:project) { submitter.projects.create(FactoryGirl.attributes_for(:project)) }
  before :each do
    DatabaseCleaner.clean
  end

  context "for update" do
    it "validates with just name" do
      params = { name: "banana" }
      form = ProjectForm.for_update(params, project)
      expect(form.valid?).to eql true
      expect(form.name).to eql "banana"
    end
    it "validates with just description" do
      params = { description: "banana" }
      form = ProjectForm.for_update(params, project)
      expect(form.valid?).to eql true
      expect(form.description).to eql "banana"
    end
    it "allows trivial change to url" do
      params = { url: "http://asdf.com" }
      form = ProjectForm.for_update(params, project)
      expect(form.valid?).to eql true
      expect(form.url).to eql "http://asdf.com"
    end
  end

end
