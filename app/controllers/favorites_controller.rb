class FavoritesController < ApplicationController
  # GET /favorites
  # GET /favorites.xml
  before_filter :login_required 
  layout 'main'
  
  def index
    @listings =current_user.favorite_listings
    
    #ugly
    #since listing lists are shared, identifies the list as favorites list as opposed to listing list, to gain additional functionality
    @this_is_favorites = true

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listings }
    end
  end

  # GET /favorites/1
  # GET /favorites/1.xml
  def show
    @favorite = Favorite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @favorite }
    end
  end

  # GET /favorites/new
  # GET /favorites/new.xml
  def new
    @favorite = Favorite.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @favorite }
    end
  end

  # POST /favorites
  # POST /favorites.xml
  def create
    respond_to do |format|
      #need to call create on a listing to increment counter
      if Listing.find(params[:listing_id]).favorites.create(:user_id=>current_user.id)
        format.xml  { render :xml => @favorite, :status => :created, :location => @favorite }
      else
        format.xml  { render :xml => @favorite.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.xml
  def destroy
    @listing = Listing.find(params[:listing_id])
    # need to delete on current user for security
    current_user.favorite_listings.delete(@listing)
    Listing.decrement_counter( :favorites_count, @listing.id)

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
  
  private
  
end
