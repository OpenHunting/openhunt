class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects, id: false do |t|
      t.uuid :id, primary_key: true

      t.string :name, null: false
      t.string :description, null: false
      t.string :url, null: false
      t.string :normalized_url, null: false

      t.string :bucket, null: false

      t.uuid :user_id, null: false

      t.integer :votes_count, default: 0

      t.timestamps null: false
    end

    add_index :projects, :bucket
  end
end
