# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  screen_name       :string           not null
#  name              :string
#  profile_image_url :string
#  twitter_id        :string
#  location          :string
#  moderator         :boolean          default(FALSE)
#  banned            :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_screen_name  (screen_name)
#

require 'rails_helper'

RSpec.describe User, type: :model do

  let(:submitter) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { submitter.projects.create(FactoryGirl.attributes_for(:project)) }

  context "voting" do
    it "cannot vote twice for same project" do
      user = FactoryGirl.create(:user)
      user.vote(project)
      user.vote(project)
      expect(user.votes.count).to eql 1
    end
  end

  context "moderator" do
    it "make_moderator" do
      user.update_attributes!(moderator: true)
      user2 = FactoryGirl.create(:user)
      user.make_moderator(user2)
      expect(user2.moderator).to eql true
    end
    it "remove_moderator" do
      user.update_attributes!(moderator: true)
      user2 = FactoryGirl.create(:user, moderator: true)
      user.remove_moderator(user2)
      expect(user2.moderator).to eql false
    end
  end

  it "checks is user is submitter" do
    expect(submitter.is_submitter?(project)).to eql true
    expect(user.is_submitter?(project)).to eql false
  end
end
