class CreateDailyDigests < ActiveRecord::Migration
  def change
    create_table :daily_digests do |t|
      t.boolean :sent
      t.string :bucket
      t.json :contents

      t.timestamps null: false
    end
  end
end
