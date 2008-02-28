class Listing < ActiveRecord::Base
  has_many :favorites
  has_many :visuals
  has_many :broker_flags
  has_many :na_flags
  has_many :bogus_flags
  has_one :listing_info
  belongs_to :apt_type
  belongs_to :rent_range
  belongs_to :nhood
  belongs_to :user
  
# listings need to be versioned for auditing

  def visuals?
    !(visuals.size == 0)
  end
  
  def listing_info?
    !listing_info.nil?
  end
  
  def photo_access?
    true
    #photos.size = 3
  end
  
  def video_access?
    videos?
  end
  
  def listing_info_access?
    listing_info?
  end
  
end
