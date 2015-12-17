class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|

      t.uuid :user_id, null: false
      t.uuid :project_id, null: false

      t.timestamps null: false
    end

    # TODO: need some indexes here
  end
end
