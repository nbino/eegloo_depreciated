class Listing < ActiveRecord::Base
	belongs_to :nhood
  belongs_to :rent_range
  belongs_to :apt_type
  
  has_many :favorites
  has_many :bogus_flags
  has_many :broker_flags
  has_many :n_a_flags
  has_many :visuals
  has_many :comments
  
  #validates_presence_of :address1 
	
  def Listing.find_favorites(user_id)
    Favorite.find :all, :conditions=>{:user_id=>user_id}
  end
  
end
