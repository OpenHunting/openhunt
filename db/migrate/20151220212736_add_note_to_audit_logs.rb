class AddNoteToAuditLogs < ActiveRecord::Migration
  def change
    add_column :audit_logs, :note, :string
  end
end
