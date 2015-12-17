class CreateAuditLogs < ActiveRecord::Migration
  def change
    create_table :audit_logs do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :type

      t.timestamps null: false
    end
  end
end
