class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :body, null: false

      t.boolean :anonymous, default: false
      t.uuid :user_id, null: false
      t.uuid :project_id, null: false

      t.timestamps null: false
    end

    # TODO: need some indexes here
  end
end
