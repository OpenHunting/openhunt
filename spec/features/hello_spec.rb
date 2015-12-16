require "rails_helper"

RSpec.feature "Client Side Hello", js: true, type: :feature do
  scenario "When user navigates to /hello, it should say hello" do
    visit "/hello"

    user = ENV['USER']
    # page.save_screenshot(Rails.root.join('tmp/screen.png'))
    expect(page).to have_content("Hello #{user}")
  end

end
