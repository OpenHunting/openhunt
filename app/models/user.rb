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
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_screen_name  (screen_name)
#

class User < ActiveRecord::Base
  has_many :votes
  has_many :projects

  has_one :list_subscriber

  has_many :feedbacks

  def vote(project)
    return unless project.present?

    Vote.find_or_create_by({
      user_id: self.id,
      project_id: project.id,
    })

    project.reload

    self
  end

  def unvote(project)
    return unless project.present?

    Vote.where({
      user_id: self.id,
      project_id: project.id,
    }).destroy_all

    project.reload

    self
  end

  def match_votes(project_ids)
    Vote.select(:project_id).where({
      user_id: self.id,
      project_id: project_ids
    }).map(&:project_id)
  end

  def voted_projects
    project_ids = Vote.select(:project_id).where({
      user_id: self.id,
    }).map(&:project_id)

    Project.where(id: project_ids)
  end

  def submitted_projects
    project_ids = Project.select(:id).where({
      user_id: self.id,
    }).map(&:id)

    Project.where(id: project_ids)
  end

  def submitted_project_today?
    bucket = Project.bucket(Time.find_zone!(Settings.base_timezone).now)
    Project.where(user_id: self.id, bucket: bucket).count > 0
  end

end
