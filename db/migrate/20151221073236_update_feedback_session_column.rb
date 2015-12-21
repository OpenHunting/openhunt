class UpdateFeedbackSessionColumn < ActiveRecord::Migration
  def change
    rename_column :feedbacks, :session_id, :anon_user_hash
  end
end
