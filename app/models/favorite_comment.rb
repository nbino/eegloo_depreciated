class FavoriteComment < Comment
  belongs_to :favorite, :counter_cache=>true
  belongs_to :author, :class_name=>'User'
end
