class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :type
      t.integer :listing_info_id, :light_level_id, :window_direction_id, :length, :width
      
      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
