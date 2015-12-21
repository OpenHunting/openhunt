class AddFormatToListSubscribers < ActiveRecord::Migration
  def change
    add_column :list_subscribers, :format, :string
  end
end
