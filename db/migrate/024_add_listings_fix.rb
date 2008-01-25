class AddListingsFix < ActiveRecord::Migration
  def self.up
    task :add_data => :environment do
    puts "yeah dude"
    
      Listing.create(
      :address1 => "512 E12th St",
      :nhood_id => 5,
      :apt_type_id => 1,
      :lease_experation_date => "06/01/2007",
      :rent_range_id => 4,
      :roach_problem => 1)
    
    Listing.create(
      :address1 => "514 E12th St",
      :nhood_id => 5,
      :apt_type_id => 2,
      :lease_experation_date => "07/01/2007",
      :rent_range_id => 4,
      :roach_problem => 1)
      
      Listing.create(
        :address1 => "516 E12th St",
        :nhood_id => 5,
        :apt_type_id => 3,
        :lease_experation_date => "07/01/2007",
        :rent_range_id => 4,
        :roach_problem => 1)
      
      Listing.create(
        :address1 => "518 E12th St",
        :nhood_id => 5,
        :apt_type_id => 1,
        :lease_experation_date => "08/01/2007",
        :rent_range_id => 5,
        :roach_problem => 1)
      
      Listing.create(
        :address1 => "520 E12th St",
        :nhood_id => 5,
        :apt_type_id => 2,
        :lease_experation_date => "08/01/2007",
        :rent_range_id => 3,
        :roach_problem => 1)
      
      Listing.create(
        :address1 => "522 E12th St",
        :nhood_id => 5,
        :apt_type_id => 1,
        :lease_experation_date => "06/01/2007",
        :rent_range_id => 5,
        :roach_problem => 1)
      
      Listing.create(
        :address1 => "524 E12th St",
        :nhood_id => 5,
        :apt_type_id => 2,
        :lease_experation_date => "06/01/2007",
        :rent_range_id => 4,
        :roach_problem => 1)
      
      Listing.create(
        :address1 => "526 E12th St",
        :nhood_id => 5,
        :apt_type_id => 2,
        :lease_experation_date => "08/01/2007",
        :rent_range_id => 5,
        :roach_problem => 0)
      
      Listing.create(
        :address1 => "528 E12th St",
        :nhood_id => 5,
        :apt_type_id => 2,
        :lease_experation_date => "06/01/2007",
        :rent_range_id => 5,
        :roach_problem => 0)
      
      Listing.create(
        :address1 => "530 E12th St",
        :nhood_id => 5,
        :apt_type_id => 2,
        :lease_experation_date => "08/01/2007",
        :rent_range_id => 4,
        :roach_problem => 0)
  end

  def self.down
    Nhood.delete_all
  end
end
