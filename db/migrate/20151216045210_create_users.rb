class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :screen_name, null: false
      t.string :name
      t.string :profile_image_url
      t.string :twitter_id
      t.string :location

      t.boolean :moderator, default: false
      t.boolean :banned, default: false
      t.timestamps null: false
    end

    add_index :users, :screen_name
  end
end
