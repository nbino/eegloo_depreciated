class AttrValue < ActiveRecord::Base
  
  def to_s
    name
  end
  
  # none should always be min id
  def none?
    least_desirable?
  end
  
  #attributes should always be ordered from least desirable to most in order of ids
  def least_desirable?
    id == self.class.find(:first, :order=>'id ASC').id
  end
  
  def most_desirable?
    id == self.class.find(:first, :order=>'id DESC').id
  end
  
end
