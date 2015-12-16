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
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class User < ActiveRecord::Base
  has_many :votes
  has_many :projects

  has_one :list_subscriber

  def vote(project)
    return unless project.present?

    Vote.find_or_create_by({
      user_id: self.id,
      project_id: project.id,
    })
  end

  def unvote(project)
    return unless project.present?

    Vote.where({
      user_id: self.id,
      project_id: project.id,
    }).destroy_all
  end
end
