class AddWeeklyToListSubscribers < ActiveRecord::Migration
  def change
    add_column :list_subscribers, :weekly, :boolean
  end
end
