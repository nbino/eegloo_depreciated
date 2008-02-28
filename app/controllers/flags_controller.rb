class FlagsController < ApplicationController
  # GET /favorites
  # GET /favorites.xml
  before_filter :login_required
  
  def create
    
    respond_to do |format|
      # very ugly, but prevents generation of custom controllers and views for each flag type. hopefully i'll think of more elegant way down the line
      @listing_id = params[:listing_id]
      listing = Listing.find(@listing_id)
      @flag_type=params[:type]
      flag = case @flag_type
                when 'bogus'
                  collection = listing.bogus_flags
                when 'na'
                  collection = listing.na_flags
                when 'broker'
                  collection = listing.broker_flags
                else
                  raise 'Invalid flag type'
                end
      
      if collection.create({:user_id => session[:user_id]})
        format.js
        format.html { redirect_to :action => "new" }
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
