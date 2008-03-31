module ListingsHelper

  def  check_search_access
    'disabled' unless current_user.listing_info_access?
  end

end
