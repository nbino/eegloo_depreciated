# flags need to be versioned for auditing

class Flag < ActiveRecord::Base
  validates_uniqueness_of :listing_id, :scope => [:user_id]
end
