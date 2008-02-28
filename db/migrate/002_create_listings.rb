class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.belongs_to :user, :null => false
      t.string :address, :cross_street
      t.integer :apt_type_id, :nhood_id, :rent_range_id
      t.integer :bogus_flags_count, :broker_flags_count, :na_flags_count, :favorites_count, :default=>0
      t.datetime :avail_date
      t.timestamps
    end
 end

  def self.down
    drop_table :listings
  end
end
