# == Schema Information
#
# Table name: users
#
#  id                :uuid(16)         primary key
#  screen_name       :string           not null
#  name              :string
#  profile_image_url :string
#  twitter_id        :string
#  location          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  sqlite_autoindex_users_1  (id) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do

  let(:submitter) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }

  context "voting" do
    before :each do
      proj = FactoryGirl.build(:project)
      submitter.projects << proj
    end

    it "cannot vote twice for same project" do
      user = FactoryGirl.create(:user)
      proj = submitter.projects.first
      user.vote(proj)
      user.vote(proj)
      expect(user.votes.count).to eql 1
    end
  end
end
