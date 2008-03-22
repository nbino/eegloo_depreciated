class Listing < ActiveRecord::Base
  
  has_many :favorites
  has_many :photos
  has_many :movies
  has_many :broker_flags
  has_many :na_flags
  has_many :bogus_flags
  has_many :listing_comments
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
    :cellphone_q]
    
    has_many :comments, :class_name=>'ListingComment', :include=>:author
    
    
  # listings need to be versioned for auditing
  
  def visuals?
    !(visuals.size == 0)
  end
  
  def listing_info?
    !listing_info.nil?
  end
  
  #if param operator is '=', no need to include them in SQL_OPERATORS as that is the default. to exlude params for special handling use operatlor '#'
  SQL_OPERATORS = 
  {
  'avail_date'=>'<=',
  'ac_type_id'=>'>=',
  'bathroom_n_id'=>'>=',
  'no_of_balconies'=>'>=',
  'no_of_bathrooms'=>'>=',
  'sq_footage'=>'>=',
  'ceiling_height'=>'>=',
  'ubound'=>'<=',
  'nhoods'=>'#',
  'comment'=>'LIKE'}
      
  def self.do_search(params, user_id, limit)
       #expects params hash
       
      conditions = []
      
      # add wildcard characters to LIKE parameter
      
      #process params
      if params != []
        
        params["avail_date"] = Date.parse(params["avail_date"]).to_s(:db) unless params["avail_date"].nil?
        
        params.each {|key,val| params [key] = "%#{val}%" if val != '' && SQL_OPERATORS[key] == 'LIKE'}
        
        #now join params with operators. exclude IN
        params.each {|key, val| conditions << "#{key} #{SQL_OPERATORS[key]||'='} :#{key}" unless SQL_OPERATORS[key]=='#'}
       
        #add parans for IN operator and join array
        conditions << "nhood_id IN (#{params['nhoods'].join(',')})" unless params['nhoods'].nil? || params['nhoods'] == []
      end
        
      
      # set up associations
      has_one :read_by_current_user, :class_name=>'ReadListing', :conditions=>"read_listings.user_id=#{user_id}"
      has_one :flagged_na_by_current_user, :class_name=>'NaFlag', :conditions=>"flags.user_id=#{user_id}"
      has_one :flagged_bogus_by_current_user, :class_name=>'BogusFlag', :conditions=>"flags.user_id = #{user_id}"
      has_one :flagged_broker_by_current_user, :class_name=>'BrokerFlag', :conditions=>"flags.user_id = #{user_id}"
      has_one :current_user_favorite, :class_name=>'Favorite', :conditions=>"favorites.user_id = #{user_id}"
      
      self.find(
        :all,
        :include => [
          :listing_info, 
          :rent_range, 
        #  :listing_comments,  - these two associations cause include to silently fail for mysterious reasons
        # :photos, 
         :read_by_current_user,
          :flagged_na_by_current_user, 
          :flagged_bogus_by_current_user, 
          :flagged_broker_by_current_user, :current_user_favorite
          ],
        :conditions=>[conditions.join(' AND '), params],
        :limit=>limit)

 end
  
  
end
