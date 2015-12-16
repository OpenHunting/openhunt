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
      20.times do
        user = FactoryGirl.create(:user)
        proj = FactoryGirl.build(:project)
        user.projects << proj
      end
    end

    it "created 20 projects" do
      expect(Project.count).to eql 20
    end
  end

end
