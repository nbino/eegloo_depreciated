class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.column :user_id, :integer, :null => false 
      t.column :listing_id, :integer, :null => false
      t.column :description, :string
      t.integer :position
    end
  end

  def self.down
    drop_table :favorites
  end
end
