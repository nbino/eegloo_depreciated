class Listing < ActiveRecord::Base
  
  # in order to add conditions to generated LEFT JOIN, :conditions string needs to be parametrized. this is achieved by executing has_one after class definition.
  # generates flagged_na_by_current_user, flagged_bogus_by_current_user, flagged_broker_by_current_user and current_user_favorite
 
  # current_user_id has to be called before find is performed that :include these associations
  
  @@current_user_id_set = false
  
  def self.current_user_id=(user_id)
    has_one :flagged_na_by_current_user, :class_name=>'NaFlag', :conditions=>"flags.user_id=#{user_id}"
    has_one :flagged_bogus_by_current_user, :class_name=>'BogusFlag', :conditions=>"flags.user_id = #{user_id}"
    has_one :flagged_broker_by_current_user, :class_name=>'BrokerFlag', :conditions=>"flags.user_id = #{user_id}"
    has_one :current_user_favorite, :class_name=>'Favorite', :conditions=>"favorites.user_id = #{user_id}"
    @@current_user_id_set = true
  end
  
  # mok associations to prevent use without initializeing current_user_id
  
  def flagged_na_by_current_user; user_id_not_set?; end
  def flagged_bogus_by_current_user; user_id_not_set?; end
  def flagged_broker_by_current_user; user_id_not_set?; end
  def current_user_favorite; user_id_not_set; end
  
  def flagged_na_by_current_user?; flagged_na_by_current_user ? true : false; end
  def flagged_bogus_by_current_user?; flagged_bogus_by_current_user ? true : false; end
  def flagged_broker_by_current_user?; flagged_broker_by_current_user ? true : false; end
  def current_user_favorite?; current_user_favorite ? true : false; end
    
  def user_id_not_set?
    raise 'Listing#current_user_id has not been set. Set and rerun the query.' unless @@current_user_id_set
    false
  end
  
  has_many :favorites
  has_many :visuals
  has_many :broker_flags
  has_many :na_flags
  has_many :bogus_flags
  has_one :listing_info
  has_many :listing_comments, :include=>:author
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
