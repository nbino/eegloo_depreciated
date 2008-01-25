class AttributeValue < ActiveRecord::Base
end

class VisualType < AttributeValue
  has_many :visuals
end

