class FavoritesController < ApplicationController
  # GET /favorites
  # GET /favorites.xml
  before_filter :login_required
  layout 'main'
  
  def index
    @listings = User.find(session[:user_id]).favorite_listings

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

  # GET /favorites/1/edit
  def edit
    @favorite = Favorite.find(params[:id])
  end

  # POST /favorites
  # POST /favorites.xml
  def create
    @listing_id = params[:listing_id]
    
    respond_to do |format|
      if Listing.find(params[:listing_id]).favorites.create({:user_id => session[:user_id]})
        #format.js
        format.html { render :partial=>'create' }
        format.xml  { render :xml => @favorite, :status => :created, :location => @favorite }
      else
        flash[:notice] = 'Add to favorites failed. Please try again.'
        format.js
        format.html { render :action => "new" }
        format.xml  { render :xml => @favorite.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # PUT /favorites/1
  # PUT /favorites/1.xml
  
  def update
    @favorite = Favorite.find(params[:id])

    respond_to do |format|
      if @favorite.update_attributes(params[:favorite])
        flash[:notice] = 'Favorite was successfully updated.'
        format.html { redirect_to(@favorite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @favorite.errors, :status => :unprocessable_entity }
      end
    end
  
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.xml
  def destroy
    @favorite = Favorite.find(params[:id])
    @user.favorites.delete (@favorite)
    Listing.decrement_counter( :favorite_count, @listing.id)

    respond_to do |format|
      fromat.js {}
      format.html { redirect_to(favorites_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
end
