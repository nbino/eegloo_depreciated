class ListingInfo < ActiveRecord::Base
  has_many :bedrooms
  has_one :livingroom
  belongs_to :listing 
  belongs_to :floor_type
  belongs_to :heat_q
  belongs_to :ac_type
  belongs_to :roof_access_type
  belongs_to :back_yard_type
  belongs_to :street_noise_level
  belongs_to :nbors_noise_level
  belongs_to :maintenance_q
  belongs_to :appliances_q
  belongs_to :bathroom_q
  belongs_to :cellphone_q
  belongs_to :cellphone_provider
  belongs_to :pets
  
  MAX_BATHROOMS = 3
  
  def livingroom_info=(livingroom_info)
    build_livingroom livingroom_info
  end
  
  def bedrooms_info=(bedrooms_info)
    bedrooms.build bedrooms_info
  end
  
  def livingroom?
    !livingroom.nil?
  end
  
  def quiet?
    nbors_noise_level.most_desirable? && street_noise_level.most_desirable?
  end
  
end
