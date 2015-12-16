# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  description    :string           not null
#  url            :string           not null
#  normalized_url :string           not null
#  user_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Project, type: :model do
  it "exists" do
    user = FactoryGirl.create(:user)
    proj = FactoryGirl.build(:project)
    user.projects << proj
    expect(proj.name).to eql "asdf"
  end

  context "featured" do
    before :each do
      DatabaseCleaner.clean
      # setup projects
      20.times do |i|
        user = FactoryGirl.create(:user)
        proj = FactoryGirl.build(:project)
        user.projects << proj
      end
      # setup more users who will vote.
      50.times do |i|
        user = FactoryGirl.create(:user)
        # each user votes 3 times
        3.times do
          rand_proj = Project.offset(rand(Project.count)).first
          user.vote(rand_proj)
        end
      end
    end

    it "user cannot vote twice for same project" do
      user = FactoryGirl.create(:user)
      proj = Project.first
      user.vote(proj)
      user.vote(proj)
      expect(user.votes.count).to eql 1
    end

    it "sorts by featured" do
      byebug
      expect(Project.featured.first).to eql Project.last
    end

  end

end
