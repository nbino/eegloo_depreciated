class CreateAttrValues < ActiveRecord::Migration
  def self.up
    create_table :attr_values do |t|
      t.string :name
      t.string :type
      t.integer :acc, :default=>0 #accessory flag field
      
      t.timestamps
    end
  
# searh assumes that qualitative values should range from bad to good  

    %w{Loud Some noise Quiet}.each do |name| 
      NborsNoiseLevel.create :name => name
      StreetNoiseLevel.create :name => name
    end
    
    
    %w{Dark Dim Bright}.each {|name| LightLevel.create :name => name}
    
    ['Garden', 'Street', 'Air Shaft'].each {|name| WindowDirection.create :name => name}
    
    %w{Poor Average Excellent}.each do |name| 
      HeatQ.create :name => name
      BathroomQ.create :name => name
      AppliancesQ.create :name => name
      CellphoneQ.create :name => name
      MaintenanceQ.create :name => name
      HeatQ.create :name => name
    end
    
    ['No', 'Cats', 'Dogs', 'Cats and Dogs'].each {|name| Pets.create :name => name}
    
    %w{Carpet Hardwood Linoleum}.each {|name| FloorType.create :name => name}
    
    %w(None Central Window Wall).each {|name| AcType.create :name => name}
    
    %w(None Private Public).each do |name| 
      RoofAccessType.create :name => name
      BackYardType.create :name => name
    end
    
   [
    'Battery Park',
    'Chelsea' ,
    'Columbus Circle' ,
    'East Village',
    'Financial District' ,
    'Flatiron' ,
    'Gramercy/Flatiron' ,
    'Greenwich Village',
    'Harlem',
    'Hell\'s Kitchen',
    'Lincoln Center',
    'Lower East Side',
    'Meatpacking District',
    'Midtown East',
    'Midtown West',
    'Murray Hill',
    'NoHo',
    'NoLita',
    'Rockefeller Center',
    'SoHo',
    'Theater District',
    'Times Square',
    'TriBeCa',
    'Union Square',
    'Upper East Side',
    'Upper West Side',
    'West Village'
    ].each {|name| Nhood.create :name => name}

  end

  
  def self.down
    drop_table :attr_values
  end
end
