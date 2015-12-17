class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :body, null: false

      t.boolean :anonymous, default: false
      t.integer :user_id, null: false
      t.integer :project_id, null: false

      t.timestamps null: false
    end

    # TODO: need some indexes here
  end
end
