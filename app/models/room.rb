class Room < ActiveRecord::Base
  belongs_to :listing_info
  belongs_to :light_level
  belongs_to :window_direction
end
