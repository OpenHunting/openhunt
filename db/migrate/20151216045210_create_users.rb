class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.uuid :id, primary_key: true

      t.string :screen_name, null: false
      t.string :name
      t.string :profile_image_url
      t.string :twitter_id
      t.string :location

      t.timestamps null: false
    end

    add_index :users, :screen_name
  end
end
