class AddNhoods < ActiveRecord::Migration
  def self.up
    
    
  end

  def self.down
    Nhood.delete_all
  end
end
