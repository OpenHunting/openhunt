class CreateWeeklyDigests < ActiveRecord::Migration
  def change
    create_table :weekly_digests do |t|
      t.boolean :sent
      t.string :bucket_range
      t.json :contents

      t.timestamps null: false
    end
  end
end
