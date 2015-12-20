require 'rails_helper'

RSpec.describe Project, type: :model do
  before :each do
    DatabaseCleaner.clean
    new_time = Time.local(2015, 12, 15, 12, 0, 0)
    Timecop.freeze(new_time)
  end
  after do
    Timecop.return
  end

  context "single project" do
    let(:submitter) { FactoryGirl.create(:user) }
    let(:project) { submitter.projects.create(FactoryGirl.attributes_for(:project)) }
    let(:submitter2) { FactoryGirl.create(:user) }
    let(:project_without_www) { submitter.projects.create(FactoryGirl.attributes_for(:project, url: "https://asdf.com")) }

    it "detects duplicate new url only lacks www" do
      project # create the project first, has url 'www.asdf.com'
      result = Project.get_duplicate_by_url("http://asdf.com")
      expect(result.id).to eql project.id
    end
    it "detects duplicate new url only has extra www" do
      project_without_www
      result = Project.get_duplicate_by_url("http://www.asdf.com")
      expect(result.id).to eql project_without_www.id
    end

    it "duplicate_exists?" do
      project
      result = Project.duplicate_exists?("http://asdf.com")
      expect(result).to eql true
      project_without_www
      result = Project.duplicate_exists?("http://www.asdf.com")
      expect(result).to eql true
    end

    it "calculates a score" do
      project.stub(:votes_count).and_return(5)
      project.stub(:created_at).and_return(4.hours.ago.to_datetime)
      # using the simple, old algorithm:
      #   votes / (hours_since_submission + 2) ** gravity
      #   5     / (         4            + 2 ) **   1.8   = 0.412346
      expect(project.score.round(6)).to eql 0.412346
    end
  end

  context "buckets" do
    it "calculates the right bucket" do
      expect(Project.bucket(Time.now)).to eql "20151215"
    end
    it "calculates sat/sun in same bucket" do
      saturday = Time.local(2015,12,12,12,0,0)
      sunday = Time.local(2015,12,13,12,0,0)
      expect(Project.bucket(saturday)).to eql "20151213"
      expect(Project.bucket(sunday)).to eql "20151213"
    end
    it "gets prev bucket" do
      expect(Project.prev_bucket(Time.now)).to eql "20151214"
    end
    it "prev bucket is a Friday if today is a Sunday" do
      time = Time.now - 2.days
      expect(Project.prev_bucket(time)).to eql "20151211"
    end
    it "next bucket is nil if time is current" do
      expect(Project.next_bucket(Time.now)).to eql nil
    end
    it "gets next bucket" do
      expect(Project.next_bucket(Time.now - 1.day)).to eql "20151215"
    end
    it "next bucket is a Monday if today is a Saturday" do
      time = Time.now - 3.days

      expect(Project.next_bucket(time)).to eql "20151214"
    end
    it "next bucket is nil if current day is Saturday" do
      Timecop.freeze(Time.local(2015, 12, 12, 12, 0, 0))
      expect(Project.next_bucket(Time.now)).to eql nil
      Timecop.return
    end

  end
end
