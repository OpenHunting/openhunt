# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  description     :string           not null
#  url             :string           not null
#  normalized_url  :string           not null
#  bucket          :string           not null
#  user_id         :integer          not null
#  votes_count     :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  feedbacks_count :integer          default(0)
#
# Indexes
#
#  index_projects_on_bucket  (bucket)
#

require 'rails_helper'

RSpec.describe Project, type: :model do

  context "single project" do
    let(:submitter) { FactoryGirl.create(:user) }
    let(:project) { submitter.projects.create(FactoryGirl.attributes_for(:project)) }
    before :each do
      DatabaseCleaner.clean
      new_time = Time.local(2015, 12, 15, 12, 0, 0)
      Timecop.freeze(new_time)
    end
    after do
      Timecop.return
    end
    it "calculates a score" do
      project.stub(:votes_count).and_return(5)
      project.stub(:created_at).and_return(4.hours.ago.to_datetime)
      # using the simple, old algorithm:
      #   votes / (hours_since_submission + 2) ** gravity
      #   5     / (         4            + 2 ) **   1.8   = 0.412346
      expect(project.score.round(6)).to eql 0.412346
    end
    it "calculates the right bucket" do
      expect(Project.bucket(Time.now)).to eql "20151215"
    end
    it "calculates sat/sun in same bucket" do
      saturday = Time.local(2015,12,12,12,0,0)
      sunday = Time.local(2015,12,13,12,0,0)
      expect(Project.bucket(saturday)).to eql "20151212-20151213"
      expect(Project.bucket(sunday)).to eql "20151212-20151213"
    end
  end


  context "featured" do
    before :all do
      DatabaseCleaner.clean
      # create projects
      25.times do |i|
        user = FactoryGirl.create(:user)
        proj = FactoryGirl.build(:project, created_at: Time.now + (i * 2).hours)
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
      expect(projects_page_1.last.id).to_not eql projects_page_2.first.id
      expect(projects_page_1.last.score).to be >= projects_page_2.first.score
    end
  end

end
