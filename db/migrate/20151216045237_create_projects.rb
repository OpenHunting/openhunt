class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.string :name, null: false
      t.string :description, null: false
      t.string :url, null: false
      t.string :normalized_url, null: false

      t.references(:user, null: false)

      t.integer :votes_count, default: 0

      t.timestamps null: false
    end
  end
end
