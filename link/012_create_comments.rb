class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.belongs_to :user, :listing
      t.string :type
      t.string :content
      t.integer :rating, :default => 0
      t.boolean :private, :default => false
      t.timestamps
    end
    
    Listing.find(:all, :limit=>20).each do |listing| 
      listing.comments.create :user_id=>2,:content=>'Leo sucks'
      listing.comments.create :user_id=>3,:content=>'Long live Leo'
    end
    
  end

  def self.down
    drop_table :comments
  end
end
