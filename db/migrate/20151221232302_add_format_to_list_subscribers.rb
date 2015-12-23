class AddFormatToListSubscribers < ActiveRecord::Migration
  def change
    add_column :list_subscribers, :email_format, :string
  end
end
