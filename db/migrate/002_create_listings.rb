class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.belongs_to :user, :null => false
      t.string :address, :cross_street
      t.float :latitude, :longtitude
      t.integer :apt_type_id, :nhood_id, :rent_range_id
      t.integer :bogus_flag_count, :broker_flag_count, :na_flag_count, :favorites_count, :listing_comments_count, :default=>0
      t.datetime :avail_date
      t.timestamps
    end
 end

  def self.down
    drop_table :listings
  end
end
