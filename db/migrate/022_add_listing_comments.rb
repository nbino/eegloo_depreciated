class AddListingComments < ActiveRecord::Migration
  def self.up
    add_column :listings, :comment, :string
    
  end

  def self.down
    remove_column :listings, :comment
  end
end
