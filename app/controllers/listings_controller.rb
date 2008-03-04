class ListingsController < ApplicationController
  # GET /listings
  # GET /listings.xml
  
  before_filter :login_required
  
  def index
    
    @apt_types = AptType.find :all
    @nhoods = Nhood.find :all
    @ac_types = AcType.find :all
    @cellphone_select = CellphoneQ.find :all
    @maintenance_select = MaintenanceQ.find :all
    @heat_select = HeatQ.find :all
    @bathroom_select = BathroomQ.find :all
    @appliances_select = AppliancesQ.find :all
    @cellphone_select = CellphoneQ.find :all
    @nbors_noise_levels = NborsNoiseLevel.find :all
    @street_noise_levels = StreetNoiseLevel.find :all
    @back_yard_types = BackYardType.find :all
    @roof_access_types = RoofAccessType.find :all
    @pets_choices = Pets.find :all
    @floor_types = FloorType.find(:all)
    @ac_types = AcType.find(:all)
    @light_levels = LightLevel.find(:all)
    @window_directions = WindowDirection.find(:all)
   
    if !params[:listing_info]
      @listings = Listing.find :all, :limit => 20
    else
      #clean up params
      params[:listing_info].delete_if {|key, val| val=="0" || val=="" || key=='pests'}
      
      @listings = Listing.do_search params[:listing_inf], current_user.id, 20
      
    end

    respond_to do |format|
      format.html { render :layout => "main" }
      format.xml  { render :xml => @listings }
    end
  end

  # GET /listings/1
  # GET /listings/1.xml
  def show
    @listing = Listing.find(params[:id])
    @comment = ListingComment.new()
    respond_to do |format|
      format.html { render :layout => "main" }
      format.xml  { render :xml => @listing }
    end
  end

  # GET /listings/new
  # GET /listings/new.xml
  def new
    @listing = Listing.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @listing }
    end
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
  end

  # POST /listings
  # POST /listings.xml
  def create
    @listing = Listing.new(params[:listing])
    @room1 = Room.new(params[:room1])
    @room2 = Room.new(params[:room2])
    @room3 = Room.new(params[:room3])
    @room4 = Room.new(params[:room4])
    @living_room = Room.new(params[:living_room])

    @room1.listing = @room2.listing = @room3.listing = @room4.listing = @living_room.listing = @listing
    
    @listing.save!
    
    respond_to do |format|
      format.html { render :action => "new" }
      format.xml  { render :xml => @listing.errors, :status => :unprocessable_entity }
    end
      
  end

  # PUT /listings/1
  # PUT /listings/1.xml
  def update
    @listing = Listing.find(params[:id])

    respond_to do |format|
      if @listing.update_attributes(params[:listing])
        flash[:notice] = 'Listing was successfully updated.'
        format.html { redirect_to(@listing) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @listing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.xml
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to(listings_url) }
      format.xml  { head :ok }
    end
  end
end
