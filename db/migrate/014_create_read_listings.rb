class CreateReadListings < ActiveRecord::Migration
  def self.up
    create_table :read_listings do |t|
      t.references :user, :listing
    end
    
  end

  def self.down
    drop_table :read_listings
  end
end
