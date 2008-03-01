class Listing < ActiveRecord::Base
  
  has_many :favorites
  has_many :visuals
  has_many :broker_flags
  has_many :na_flags
  has_many :bogus_flags
  belongs_to :apt_type
  belongs_to :rent_range
  belongs_to :nhood
  belongs_to :user
    
  has_one :listing_info, :include=>[
    :bedrooms,
    :livingroom,
    :listing,
    :floor_type,
    :heat_q,
    :ac_type,
    :roof_access_type,
    :back_yard_type,
    :street_noise_level,
    :nbors_noise_level,
    :maintenance_q,
    :appliances_q,
    :bathroom_q,
    :cellphone_q,
    :pets]
    
    has_many :comments, :class_name=>'ListingComment', :include=>:author
    
    
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
  
  SQL_OPERATORS = 
  {
  'no_of_balconies'=>'>=',
  'no_of_patios'=>'>=',
  'sq_footage'=>'>=',
  'ceiling_height'=>'>=',
  'appliance_q_id'=>'>=',
  'bathroom_q_id'=>'>=',
  'cellphone_q_id'=>'>=',
  'street_noise_level_id'=>'>=',
  'nbors_noise_level_id'=>'>=',
  'ubound'=>'<=',
  'comment'=>'LIKE'}
      
  def self.do_search(params, limit, user_id)
       #expects params hash
       
       #list all params that have operator other than "="
       
      conditions = []
      
      # first add wildcard characters to LIKE parameter
      params.each {|key,val| params[:listing_info][key] = "%#{val}%" if val != '' && SQL_OPERATORS[key] == 'LIKE'}
      
      #now join params with operators
      params .each {|key, val| conditions << "#{key} #{SQL_OPERATORS[key]||'='} :#{key}"}
      
      # set up associations
      
      has_one :flagged_na_by_current_user, :class_name=>'NaFlag', :conditions=>"flags.user_id=#{user_id}"
      has_one :flagged_bogus_by_current_user, :class_name=>'BogusFlag', :conditions=>"flags.user_id = #{user_id}"
      has_one :flagged_broker_by_current_user, :class_name=>'BrokerFlag', :conditions=>"flags.user_id = #{user_id}"
      has_one :current_user_favorite, :class_name=>'Favorite', :conditions=>"favorites.user_id = #{user_id}"
      
      Listing.find(
        :all,
        :include => [
          :listing_info, 
          :rent_range, 
          :comments, 
          :visuals,  
          :flagged_na_by_current_user, 
          :flagged_bogus_by_current_user, 
          :flagged_broker_by_current_user, :current_user_favorite],
        :conditions=>[conditions_t.join(' AND '), params],
        :limit=>limit)

 end
  
  
end
