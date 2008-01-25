class CreateAptTypes < ActiveRecord::Migration
  def self.up
    create_table :apt_types do |t|
      t.column :name, :string
      t.column :description, :string
    end
    
    AptType.create (:name=>"studio", :description=>"studio apt")
    AptType.create (:name=>"alcove studio", :description=>"alcove studio apt")
    AptType.create (:name=>"jr. 1 bedroom", :description=>"jr. 1 bedroom apt")
    AptType.create (:name=>"1 bedroom", :description=>"1 bedroom apt")
    AptType.create (:name=>"jr. 2 bedroom", :description=>"jr. 2 bedroom apt")
    AptType.create (:name=>"2 bedroom", :description=>"2 bedroom apt")
    AptType.create (:name=>"jr. 3 bedroom", :description=>"jr. 3 bedroom apt")
    AptType.create (:name=>"3 bedroom", :description=>"3 bedroom apt")
  end

  def self.down
    drop_table :apt_types
  end
end
