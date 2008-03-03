
class ListingInfosController < ApplicationController
  # GET /listing_infos
  # GET /listing_infos.xml
  before_filter :find_listing

  def index
    @listing_infos = ListingInfo.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listing_infos }
    end
  end

  # GET /listing_infos/1
  # GET /listing_infos/1.xml
  def show
    @listing_info = ListingInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @listing_info }
    end
  end
  
  #[EP] For drag and drop
  def update_positions
    params[:sortable_list].each_index do |i|
      item = ListItem.find(params[:sortable_list][i])
      item.position = i
      item.save
    end
    @list = List.find(:all, :order => 'position')    
    render :layout => false, :action => :list
  end
  
  
  # GET /listing_infos/new
  # GET /listing_infos/new.xml
  def new
    
    @goodokbad_items = [
      {:id => :maintenance_q_id, :label => 'Maintenance', :good =>'Well-maintained', :ok =>'Maintenance ok', :poor => 'Poor maintenance'},
      {:id => :bathroom_q_id, :label => 'Bathrooms' },
      {:id => :appliances_q_id, :label => 'Appliances' },
      {:id => :heat_q_id, :label => 'Heat' },
      {:id => :street_noise_level_id, :label => 'Street Noise' },
      {:id => :nbors_noise_level_id, :label => 'Neighbor Noise' },
      {:id => :cellphone_q_id, :label => 'Cellphone' }]
      
    @items = [
      
      {:id => :elevator, :label => 'Elevator' },
      {:id => :laundry, :label => 'Laundry' },
      {:id => :gym, :label => 'Gym' }, 
      {:id => :doorman, :label => 'Doorman' },
      {:id => :broadband, :label => 'Broadband' },
      {:id => :multilevel, :label => 'Multi-level' },
      {:id => :penthouse, :label => 'Penthouse' },
      {:id => :balcony, :label => 'Balcony' },
      {:id => :backyard, :label => 'Backyard' },
      {:id => :separate_kitchen, :label => 'Separate Kitchen' },
      {:id => :roaches, :label => 'Roaches' },
      {:id => :rodents, :label => 'Rodents' },
      {:id => :rent_stabilized, :label => 'Rent Stabilized' },
      {:id => :rent_controlled, :label => 'Rent Controlled'}]
      
      
    @listing_info = ListingInfo.new
    #@listing_info = YAML.load(LISTING_YAML)
    
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
    
    apt_type = @listing.apt_type
    
    #apt_type.bedrooms.times {|i| @listing_info.bedrooms[i] = Bedroom.new}
    #@is_livingroom = apt_type.livingroom?

    respond_to do |format|
      format.html { render :layout => "main" }# new.html.erb
      format.xml  { render :xml => @listing_info }
    end
  end

  # GET /listing_infos/1/edit
  def edit
    @listing_info = ListingInfo.find(params[:id])
  end
  
  # POST /listing_infos
  # POST /listing_infos.xml
  def create
    @listing_info = ListingInfo.new(params[:listing_info])
    @listing_info.listing = @listing

    respond_to do |format|
      if @listing_info.save
        flash[:notice] = 'ListingInfo was successfully created.'
        format.html { redirect_to :controller=>:listings}
        format.xml  { render :xml => @listing_info, :status => :created, :location => @listing_info }
      else
        format.html { render :action => "new", :layout => "main" }
        format.xml  { render :xml => @listing_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /listing_infos/1
  # PUT /listing_infos/1.xml
  def update
    @listing_info = ListingInfo.find(params[:id])

    respond_to do |format|
      if @listing_info.update_attributes(params[:listing_info])
        flash[:notice] = 'ListingInfo was successfully updated.'
        format.html { redirect_to(@listing_info) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @listing_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /listing_infos/1
  # DELETE /listing_infos/1.xml
  def destroy
    @listing_info = ListingInfo.find(params[:id])
    @listing_info.destroy

    respond_to do |format|
      format.html { redirect_to(listing_infos_url) }
      format.xml  { head :ok }
    end
  end

  def find_listing
    redirect_to new_user_url unless params[:listing_id]
    @listing = Listing.find(params[:listing_id])
  end





end
