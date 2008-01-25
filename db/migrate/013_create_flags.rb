class CreateFlags < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|
      t.column :user_id, :integer, :null => false 
      t.column :listing_id, :integer, :null => false
      t.column :description, :string
      t.column :type, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
    
  end

  def self.down
  end
end
