class AddFavoritesCounts < ActiveRecord::Migration
  def self.up
    add_column :users, :favorites_count, :integer, :default => 0
  end

  def self.down
    remove_column :users, :favorites_count, :integer
  end
end
