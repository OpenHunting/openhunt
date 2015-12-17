class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|

      t.integer :user_id, null: false
      t.integer :project_id, null: false

      t.timestamps null: false
    end

    # TODO: need some indexes here
  end
end
