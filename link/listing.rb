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
  
    validates_presence_of(
        :apt_type_id,
        :rent_range_id,
        :nhood_id,
        :address, :cross_street,
        :avail_date)
  
    validates_numericality_of(
        :apt_type_id,
        :rent_range_id,
        :nhood_id,
        
        #other
        :greater_than=>0, :only_integer=>true)
          
  validates_associated(
    :apt_type,
    :rent_range,
    :nhood
    )

  #is read by current user?
  def read?
    !(read_by_current_user.nil?)
  rescue NameError
    raise 'do_search must first be performed'
  end
  
  #is current user favorite?
  def favorite?
    !(current_user_favorite.nil?)
  rescue NameError
    raise 'do_search must first be performed'
  end
  
  #is not read by current_user?
  def unread?
    !read?
  end
  
  def visuals?
    !(visuals.size == 0)
  end
  
  def listing_info?
    !listing_info.nil?
  end
  
  def flag_alert?
    broker_alert? || na_alert? || bogus_alert?
  end
  
  def broker_alert?
    broker_flag_count == 5
  end
  
  def na_alert?
    na_flag_count == 5
  end
  
  def bogus_alert?
    bogus_flag_count == 5
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
  'lbound'=>'>=',
  'nhoods'=>'#',
  'comment'=>'LIKE'}
  
  SORT_ORDER =
  {
    'created_at' => 'listings.created_at DESC',
    'favorites_count' => 'listings.favorites_count DESC',
    'lbound' => 'rent_ranges.lbound ASC'
  }
      
  def self.do_search(params, user_id, order_by='created_at', current_page=1)
       #expects params hash
       
      conditions = []
      
      #process params
      
      #emty nhoods are not ignored. 
      if  params.nil? || params.empty? || params['nhoods'].nil? || params['nhoods'].empty?
        conditions << 'nhood_id = 0' 
      else
        #add parans for IN operator and join array. "all" is a special value that means all
        conditions << "nhood_id IN (#{params['nhoods'].join(',')})" unless params['nhoods'].include? 'all'
      end
        
      
      #empty evertying else is ignored
      unless params.nil? || params.empty?
        
        params["avail_date"] = Date.parse(params["avail_date"]).to_s(:db) unless params["avail_date"].nil?
        
        params.each {|key,val| params [key] = "%#{val}%" if val != '' && SQL_OPERATORS[key] == 'LIKE'}
        
        #now join params with operators. exclude IN
        params.each {|key, val| conditions << "#{key} #{SQL_OPERATORS[key]||'='} :#{key}" unless SQL_OPERATORS[key]=='#'}
          
      end
      # set up associations
      has_one :read_by_current_user, :class_name=>'Reading', :conditions=>"readings.user_id=#{user_id}"
      has_one :current_user_favorite, :class_name=>'Favorite', :conditions=>"favorites.user_id = #{user_id}"
      
      self.find(
        :all,
        :include => [
          :listing_info, 
          :rent_range, 
      #   :listing_comments,
      #   :photos, 
          :read_by_current_user,
          :current_user_favorite
          ],
        :conditions=>[conditions.join(' AND '), params],
        :page => {:size => 20, :current => current_page},
        :order=>SORT_ORDER[order_by])
        

 end
  
  
end
