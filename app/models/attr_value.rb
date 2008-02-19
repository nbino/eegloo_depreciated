class AttrValue < ActiveRecord::Base
  
  def to_s
    name
  end
  
  def none?
    name == 'None'
  end
  
end
