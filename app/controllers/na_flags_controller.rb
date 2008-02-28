class NaFlagsController < ApplicationController
  # GET /favorites
  # GET /favorites.xml
  before_filter :login_required
  
  #there must be a way to DRY this, but haven't figured it out yet
  def create
    
    respond_to do |format|
      
      @listing_id = params[:listing_id]
      @flag_type = 'na'
      
      if Listing.find(@listing_id).na_flags.create({:user_id => session[:user_id]})
        
        format.html { render :partial=>'shared/flag' }
        format.xml  { render :xml => @favorite, :status => :created, :location => @favorite }
      else
        flash[:notice] = 'Add to favorites failed. Please try again.'
        format.js
        format.html { render :action => "new" }
        format.xml  { render :xml => @favorite.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  
end
