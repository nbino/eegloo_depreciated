class ReadListing < ActiveRecord::Base
  validates_uniqueness_of :listing_id, :scope => [:user_id]
  belongs_to :listing
end
