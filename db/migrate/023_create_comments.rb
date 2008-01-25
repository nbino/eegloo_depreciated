class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :listing_id, :integer
      t.column :user_id, :integer
      t.column :comment, :text
    end
  end

  def self.down
    drop_table :comments
  end
end
