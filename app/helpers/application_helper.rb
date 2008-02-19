# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  
  
  
  class ActionView::Helpers::FormBuilder
    def collection_radio(method, collection)
      output = ''
      collection.each {|thing| output += "#{radio_button(method, thing.id)} #{thing.name}"}
      output
    end
    
    def yes_no_radio(method)
      #form_builder.select(method, { 'No' => 0, 'Yes' => 1}, {:include_blank => 'Select'})
      output = ''
      output += "#{radio_button(method, 1)}y "
      output += "#{radio_button(method, 0)}n"
      output
    end
    
  end



  module ActiveSupport::CoreExtensions::Array::Conversions
    def to_sentence_sens_false 
      self.delete nil
      to_sentence
    end
  end
  
  module ActiveSupport::CoreExtensions::Hash::Conversions
    def keys_to_sentence_sens_false_values 
      arr = []
      self.each {|key, value| arr << key if value} 
      arr.to_sentence
    end
  end
  
  
  class Object::TrueClass
    def to_yn_s
      'Yes'
    end
  end
  
  class Object::FalseClass
    def to_yn_s
      'No'
    end
  end
  
  
  
end
