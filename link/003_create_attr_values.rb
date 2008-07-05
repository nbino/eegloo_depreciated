class CreateAttrValues < ActiveRecord::Migration
  def self.up
    create_table :attr_values do |t|
      t.string :name, :unique=>true
      t.string :type
      t.integer :acc, :default=>0 #accessory flag field
      
      t.timestamps
    end
  
# searh assumes that qualitative values should range from bad to good  

    ['a lot of', 'average', 'quiet'].each do |name| 
      NborsNoiseLevel.create :name => name
      StreetNoiseLevel.create :name => name
    end
    
    %w{dark dim bright}.each {|name| LightLevel.create :name => name}
    
    ['air shaft', 'street', 'garden'].each {|name| WindowDirection.create :name => name}
    
    %w{shared 1 2 3}.each {|name| BathroomN.create :name => name}
    
    %w{Cingular Nextel Pre-paid Sprint T-Mobile Verizon}.each {|name| CellphoneProvider.create :name => name} 
    
    %w{poor average excellent}.each do |name| 
      HeatQ.create :name => name
      BathroomQ.create :name => name
      AppliancesQ.create :name => name
      CellphoneQ.create :name => name
      MaintenanceQ.create :name => name
    end
    
    %w{linoleum carpet hardwood}.each {|name| FloorType.create :name => name}
    
    %w(no window wall central).each {|name| AcType.create :name => name}
    
    %w(none public private).each do |name| 
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
