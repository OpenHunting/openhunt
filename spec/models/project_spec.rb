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

  context "single project" do
    it "calculates a score" do
      pending 'doublecheck our algorithm returns what we expect'
    end
  end


  context "featured" do
    before :all do
      DatabaseCleaner.clean
      # create projects
      25.times do |i|
        user = FactoryGirl.create(:user)
        proj = FactoryGirl.build(:project, created_at: Time.now - (i * 2).hours)
        user.projects << proj
      end
      # create more users
      # each user will vote on 3 random projects.
      50.times do |i|
        user = FactoryGirl.create(:user)
        3.times do
          rand_proj = Project.offset(rand(Project.count)).first
          user.vote(rand_proj)
        end
      end
    end

    let(:projects_page_1) { Project.featured(1) }
    let(:projects_page_2) { Project.featured(2) }
    let(:projects_page_3) { Project.featured(3) }

    # One big test because the setup is slow
    it "return paginated results" do
      expect(projects_page_1.length).to eql 10
      expect(projects_page_2.length).to eql 10
      expect(projects_page_3.length).to eql 5
    end

    it "orders by score" do
      expect(projects_page_1.first.score).to be > projects_page_1.last.score
      expect(projects_page_1.last.score).to be > projects_page_2.first.score
    end
  end

end
