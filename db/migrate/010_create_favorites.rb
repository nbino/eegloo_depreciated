class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.belongs_to :listing, :user, :null => false
      t.integer :favorite_comments_count, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :favorites
  end
end
