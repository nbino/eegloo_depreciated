class CreateRentRanges < ActiveRecord::Migration
  def self.up
    create_table :rent_ranges do |t|
      t.column :name, :string
      t.column :description, :string
      t.column :lbound, :integer
      t.column :ubound, :integer
    end
    
    RentRange.create (:name=>"$500 - $650", :description=>"$500 - $650", :lbound=>500, :ubound=>650)
    RentRange.create (:name=>"$650 - $800", :description=>"$650 - $800", :lbound=>650, :ubound=>800)
    RentRange.create (:name=>"$800 - $1000", :description=>"$800 - $1000", :lbound=>800, :ubound=>1000)
    RentRange.create (:name=>"$1000 - $1200", :description=>"$1000 - $1200", :lbound=>1000, :ubound=>1200)
    RentRange.create (:name=>"$1200 - $1400", :description=>"$1200 - $1400", :lbound=>1200, :ubound=>1400)
    RentRange.create (:name=>"$1400 - $1600", :description=>"$1400 - $1600", :lbound=>1400, :ubound=>1600)
    RentRange.create (:name=>"$1600 - $1800", :description=>"$1600 - $1800", :lbound=>1600, :ubound=>1800)
    RentRange.create (:name=>"$1800 - $2000", :description=>"$1800 - $2000", :lbound=>1800, :ubound=>2000)
    RentRange.create (:name=>"$2000 - $2250", :description=>"$2000 - $2250", :lbound=>2000, :ubound=>2250)
    RentRange.create (:name=>"$2250 - $2500", :description=>"$2250 - $2500", :lbound=>2250, :ubound=>2500)
    RentRange.create (:name=>"$2500 - $3000", :description=>"$2500 - $3000", :lbound=>2500, :ubound=>3000)
    RentRange.create (:name=>"$3000 - $3250", :description=>"$3000 - $3250", :lbound=>3000, :ubound=>3250)
    RentRange.create (:name=>"$3250 - $3500", :description=>"$3250 - $3500", :lbound=>3250, :ubound=>3500)
    RentRange.create (:name=>"$3500 - $3750", :description=>"$3500 - $3750", :lbound=>3500, :ubound=>3750)
    RentRange.create (:name=>"$3750 - $4000", :description=>"$3750 - $4000", :lbound=>3750, :ubound=>4000)
    
  end

  def self.down
    drop_table :rent_ranges
  end
end
