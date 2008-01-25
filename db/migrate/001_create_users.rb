class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |table|
		table.column :name, :string
        table.column :login,  :string, :null => false
        table.column :password, :string, :null => false
        table.column :email, :string
	end
  end
  
  def self.down
    drop_table :users
  end
end
