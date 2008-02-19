class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.integer :user_id, :null => false
      t.string :address, :cross_street
      t.integer :apt_type_id, :nhood_id, :rent_range_id
      t.datetime :avail_date
      t.timestamps
    end
 end

  def self.down
    drop_table :listings
  end
end
