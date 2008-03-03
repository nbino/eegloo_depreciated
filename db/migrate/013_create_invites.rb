class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      #.belongs_to :user, :null => false
      t.string :email
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
