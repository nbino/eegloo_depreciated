class ListingsController < ApplicationController
  # GET /listings
  # GET /listings.xml
  
  before_filter :login_required
  #layout 'main'
  
  def load_dropdown_values
    @apt_types = AptType.find :all
    @nhoods = Nhood.find :all
    @ac_types = AcType.find :all
    @cellphone_select = CellphoneQ.find :all
    @maintenance_select = MaintenanceQ.find :all
    @heat_select = HeatQ.find :all
    @bathroom_select = BathroomQ.find :all
    @no_of_bathrooms_select = BathroomN.find :all
    @appliances_select = AppliancesQ.find :all
    @cellphone_select = CellphoneQ.find :all
    @nbors_noise_levels = NborsNoiseLevel.find :all
    @street_noise_levels = StreetNoiseLevel.find :all
    @back_yard_types = BackYardType.find :all
    @roof_access_types = RoofAccessType.find :all
    @floor_types = FloorType.find:all
    @ac_types = AcType.find:all
    @light_levels = LightLevel.find:all
    @window_directions = WindowDirection.find:all
    @cell_phone_providers_select = CellphoneProvider.find :all
    @rent_ranges = RentRange.find :all
    
  end
  
  def index
    
    load_dropdown_values
    
    #Need to specify all nhoods as default
    all_nhoods = {'nhoods'=>['all']}
    
    @listings = Listing.do_search all_nhoods, current_user.id, 10
    
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.xml  { render :xml => @listings }
    end
  end

  def search
    #for all params 0 or blank value indicates ignore
    params[:listing_info].delete_if {|key, val| val=="0" || val=="" || val=='Comment keywords'}
    
    #handle nhoods speratly
    #nhoods["all"] indicates all, so this should be ignored
    #need to copy under listing info, could not get that to work in the form
    params[:listing_info][:nhoods] = params[:nhoods]
    
    params.delete :nhoods
    
    #convert pests into roaches ants and mice
    params[:listing_info][:roaches], params[:listing_info][:ants], params[:listing_info][:mice] = 0 unless params[:listing_info][:pests_free].nil?
    params.delete :pest_free
        
    page = params[:custom_options][:page] || 1
    
    @listings = Listing.do_search params[:listing_info], current_user.id, params[:order_by], page

    respond_to do |format|
      format.html { render :partial => '/shared/listing_list'}
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
    
    load_dropdown_values
    respond_to do |format|
      format.html { render :layout => "main" }
      format.xml  { render :xml => @listing }
    end
  end

  # POST /listings
  # POST /listings.xml
  def create
    
    respond_to do |format|
      format.html { render :patial => 'shared/listing_list'}
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
        format.html { render :action => "edit" }
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
