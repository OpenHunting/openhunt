class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :url, null: false
      t.string :normalized_url, null: false

      t.string :bucket, null: false
      t.string :slug, null: false

      t.integer :user_id, null: false

      t.boolean :hidden, default: false
      t.integer :votes_count, default: 0
      t.integer :feedbacks_count, default: 0

      t.timestamps null: false
    end

    add_index :projects, :bucket
    add_index :projects, :slug
  end
end
