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

class User < ActiveRecord::Base
  has_many :votes
  has_many :projects

  has_one :list_subscriber

  has_many :feedbacks

  def self.moderators
    where(moderator: true)
  end

  def vote(project)
    return unless project.present?
    return if banned?

    Vote.find_or_create_by({
      user_id: self.id,
      project_id: project.id,
    })

    project.reload

    self
  end

  def unvote(project)
    return unless project.present?
    return if banned?

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

    Project.where(id: project_ids).includes(:user)
  end

  def submitted_projects
    project_ids = Project.select(:id).where({
      user_id: self.id,
    }).map(&:id)

    Project.where(id: project_ids).includes(:user)
  end

  def is_submitter?(project)
    projects.where(id: project.id).count > 0
  end

  def can_update?(project)
    return true if moderator?

    if is_submitter?(project) and project.created_at >= Settings.project_edit_window.minutes.ago
      return true
    end

    return false
  end

  # whether or not the user is a project owner
  def project_owner?(project)
    # TODO: this is not necessarily the project owner, just the person who posted it
    project.user_id == self.id
  end

  def submitted_project_today?
    return true if banned?

    bucket = Project.bucket(Time.find_zone!(Settings.base_timezone).now)
    Project.where(user_id: self.id, bucket: bucket).count > 0
  end

  def update_project(project, data)
    UpdateProject.call(project: project, params: data, user: self)
  end

  def hide_project(project)
    return unless moderator?

    project.hidden = true
    project.save!

    AuditLog.create!({
      item_type: "hide_project",
      moderator_id: self.id,
      target_id: project.id,
      target_type: "Project",
      target_display: project.name,
      target_url: "/detail/#{project.slug}"
    })
  end

  def unhide_project(project)
    return unless moderator?

    project.hidden = false
    project.save!

    AuditLog.create!({
      item_type: "unhide_project",
      moderator_id: self.id,
      target_id: project.id,
      target_type: "Project",
      target_display: project.name,
      target_url: "/detail/#{project.slug}"
    })
  end

  def ban_user(user)
    return unless moderator?
    return if self.id == user.id

    user.banned = true
    user.save!

    AuditLog.create!({
      item_type: "ban_user",
      moderator_id: self.id,
      target_id: user.id,
      target_type: "User",
      target_display: user.screen_name,
      target_url: "/@#{user.screen_name}"
    })
  end

  def unban_user(user)
    return unless moderator?

    user.banned = false
    user.save!

    AuditLog.create!({
      item_type: "unban_user",
      moderator_id: self.id,
      target_id: user.id,
      target_type: "User",
      target_display: user.screen_name,
      target_url: "/@#{user.screen_name}"
    })
  end

  def set_subscriber(subscriber)
    if subscriber.present?
      subscriber.user = self
      subscriber.save!
    end
  end

  def make_moderator(user)
    return unless moderator?

    user.moderator = true
    user.save!

    AuditLog.create!({
      item_type: "make_moderator",
      moderator_id: self.id,
      target_id: user.id,
      target_type: "User",
      target_display: user.screen_name,
      target_url: "/@#{user.screen_name}"
    })
  end

  def remove_moderator(user)
    return unless moderator?

    user.moderator = false
    user.save!

    AuditLog.create!({
      item_type: "remove_moderator",
      moderator_id: self.id,
      target_id: user.id,
      target_type: "User",
      target_display: user.screen_name,
      target_url: "/@#{user.screen_name}"
    })
  end
end
