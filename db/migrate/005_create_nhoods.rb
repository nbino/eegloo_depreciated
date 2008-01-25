class CreateNhoods < ActiveRecord::Migration
  def self.up
    create_table :nhoods do |t|
      t.column :name, :string
      t.column :description, :string
    end
	
  end

  def self.down
    drop_table :nhoods
  end
end
