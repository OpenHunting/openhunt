class CreateAuditLogs < ActiveRecord::Migration
  def change
    create_table :audit_logs do |t|
      t.integer :moderator_id
      t.string :item_type
      t.integer :target_id
      t.string :target_type

      t.timestamps null: false
    end
  end
end
