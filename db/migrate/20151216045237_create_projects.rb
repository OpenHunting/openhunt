class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.string :title
      t.string :description
      t.string :url

      t.references(:user)

      t.timestamps null: false
    end
  end
end
