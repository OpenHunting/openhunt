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
#  votes_count    :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Project, type: :model do
  it "exists" do
    user = FactoryGirl.create(:user)
    proj = FactoryGirl.build(:project)
    user.projects << proj
    expect(proj.name).to eql "Asdf"
  end

  context "featured" do

  end

end
