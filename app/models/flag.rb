class Flag < ActiveRecord::Base
end

class BogusFlag < Flag
  belongs_to :user
  belongs_to :listing, :counter_cache => true
end

class BrokerFlag < Flag
  belongs_to :user
  belongs_to :listing, :counter_cache => true
end

class NAFlag < Flag
  belongs_to :user
  belongs_to :listing, :counter_cache => true
end

