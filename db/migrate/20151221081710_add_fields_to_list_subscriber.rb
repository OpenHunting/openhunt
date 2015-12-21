class AddFieldsToListSubscriber < ActiveRecord::Migration
  def change
    add_column :list_subscribers, :confirmed, :boolean, default: false
    add_column :list_subscribers, :confirm_code, :string
  end
end
