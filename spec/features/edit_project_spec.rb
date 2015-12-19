require "rails_helper"

RSpec.feature "Edit Project", js: true, type: :feature do
  let(:submitter) { FactoryGirl.create(:user) }
  let(:project) { submitter.projects.create(FactoryGirl.attributes_for(:project)) }
  before :each do
    DatabaseCleaner.clean
    ApplicationController.any_instance.stub(:current_user).and_return(submitter)
  end

  scenario "User can edit a project" do
    visit "/edit/#{project.slug}"
    fill_in("Name", with: "changed banana")
    click_button("Update Project") # <= brittle selector
    page.save_screenshot(Rails.root.join('tmp/screen.png'))
    expect(page).to have_content("changed banana")
  end
end
