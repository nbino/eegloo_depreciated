class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, :email, :password, :null => false
      t.string :crypted_password, :salt, :limit => 40
      t.string :remember_token
      t.string :activation_code, :password_reset_code, :limit => 40
      t.datetime :remember_token_expires_at, :activated_at
      t.boolean :enabled, :admin, :default => false
      t.timestamps
    end
    
    
  end

  def self.down
    drop_table :users
  end
end
