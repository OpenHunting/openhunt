class CreateListSubscribers < ActiveRecord::Migration
  def change
    create_table :list_subscribers do |t|

      t.string :email, null: false
      t.boolean :subscribed, default: true

      t.references(:user)

      t.timestamps null: false
    end
  end
end
