class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.column :address1, :string
      t.column :nhood_id, :integer
      t.column :apt_type_id, :integer
      t.column :lease_experation_date, :date
      t.column :rent_range_id, :integer
      t.column :roach_problem, :integer
      t.integer :favorites_count
      t.integer :bogus_flags_count
      t.integer :broker_flags_count
      t.integer :n_a_flags_count
    end
  end

  def self.down
    drop_table :listings
  end
end

