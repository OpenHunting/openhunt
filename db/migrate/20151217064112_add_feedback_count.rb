class AddFeedbackCount < ActiveRecord::Migration
  def change
    add_column :projects, :feedbacks_count, :integer, default: 0
  end
end
