class Favorite < ActiveRecord::Base
    belongs_to :user, :counter_cache => true
    belongs_to :listing, :counter_cache => true
    
    acts_as_list :scope => :user_id
    
end
