class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :screen_name, null: false
      t.string :name
      t.string :profile_image_url
      t.string :twitter_id
      t.string :location

      t.string :email

      t.timestamps null: false
    end
  end
end
