class Visual < ActiveRecord::Base
  belongs_to :listing
  belongs_to :visual_type
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :processor => :mini_magick,
                 :max_size => 500.kilobytes,
                 :resize_to => '320x200>',
                 :thumbnails => { :thumb => '100x100>' }

  validates_as_attachment
end
