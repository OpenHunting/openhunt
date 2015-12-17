class CreateListSubscribers < ActiveRecord::Migration
  def change
    create_table :list_subscribers do |t|

      t.string :email, null: false
      t.boolean :subscribed, default: true

      t.integer :user_id, null: true


      t.timestamps null: false
    end
  end
end
