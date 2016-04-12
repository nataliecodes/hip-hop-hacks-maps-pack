class AddLocations < ActiveRecord::Migration
  def change
  	create_table :locations do |t|
		  t.string :name, index: true, null: false
		  t.string :canonical_name, null: false
		  t.string :target_type, null: false
		  t.timestamps null: false
		end
  end
end
