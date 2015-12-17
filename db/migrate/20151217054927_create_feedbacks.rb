class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :body, null: false

      t.boolean :anonymous, default: false
      t.integer :project_id, null: false

      # identify the user with one of these
      t.integer :user_id
      t.string :session_id

      t.timestamps null: false
    end

    # TODO: need some indexes here
  end
end
