class TestsController < ApplicationController
  include CoolBeans
  
  def index
    
    puts 'asdf'
    @a = method1
  end
  
end
