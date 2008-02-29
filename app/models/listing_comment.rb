class ListingComment < Comment
  belongs_to :listing, :counter_cache=>true
  belongs_to :author, :class_name=>'user'
end
