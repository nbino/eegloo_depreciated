class CreateAptTypes < ActiveRecord::Migration
  def self.up
    create_table :apt_types do |t|
      t.string :name
      t.integer :bedrooms
      t.timestamps
    end
    
    [
    {:name=>'Studio', :bedrooms=>1},
    {:name=>'Alcove studio', :bedrooms=>1},
    {:name=>'Jr. 1 bedroom', :bedrooms=>1},
    {:name=>'1 bedroom', :bedrooms=>1},
    {:name=>'Jr. 2 bedroom', :bedrooms=>2},
    {:name=>'2 bedroom', :bedrooms=>2},
    {:name=>'Jr. 3 bedroom', :bedrooms=>3},
    {:name=>'3 bedroom', :bedrooms=>3},
    {:name=>'4 bedroom', :bedrooms=>4}
    ].each {|vals| AptType.create(vals)}
    
  end

  def self.down
    drop_table :apt_types
  end
end
