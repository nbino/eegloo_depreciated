class User < ActiveRecord::Base
  has_one :listing
  
  def listing_attr=(listing_info)
    build_listing listing_info
  end
  
  def photos_access
    listing.photos?
  end
  
  def videos_access
    listing.videos?
  end
  
  
end
