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
    #create
    if livingroom.nil?
      #on create it creates associations as well
      build_livingroom livingroom_info 
    else
      #on update it does not. NEED TO CALL SAVE EXPLICITLY
      livingroom.attributes = livingroom_info
    end
    
  end
  
  def bedrooms_info=(bedrooms_info)
    if bedrooms.size == 0
      bedrooms.build bedrooms_info
    else
      #form helper for [bedrooms_info][] indexes each bedroom by id. Does not save,  NEED TO CALL SAVE EXPLICITLY
      bedrooms.each {|bedroom| bedroom.attributes = bedrooms_info[bedroom.id.to_s]}
    end
  end
  
  def livingroom?
    !livingroom.nil?
  end
  
  def quiet?
    nbors_noise_level.most_desirable? && street_noise_level.most_desirable?
  end
  
end
