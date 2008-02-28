class ListingsController < ApplicationController
  # GET /listings
  # GET /listings.xml
  
  before_filter :login_required
  
  def index
    
    @user = User.find(session[:user_id])
    @nhoods = Nhood.find :all
    @apt_types = AptType.find :all
    @rent_ranges = RentRange.find :all
    @floor_types = FloorType.find :all
    @ac_types = AcType.find :all
    @cellphone_quality_choices = CellphoneQ.find :all
    @maintenance_quality_choices = MaintenanceQ.find :all
    @heat_quality_choices = HeatQ.find :all
    @bathroom_quality_choices = BathroomQ.find :all
    @appliances_quality_choices = AppliancesQ.find :all
    @cellphone_quality_choices = CellphoneQ.find :all
    @nbors_noise_levels = NborsNoiseLevel.find :all
    @street_noise_levels = StreetNoiseLevel.find :all
    @back_yard_types = BackYardType.find :all
    @roof_access_types = RoofAccessType.find :all
    
    if !params[:listing_info]
      @listings = Listing.find :all, :limit => 20
    else
      
      #list all values that have operator other than "="
      sql_ops = 
      {
      #~ 'apt_type_id'=>'=',
      #~ 'avail_date'=>'=',
      #~ 'n_hood'=>'=',
      #~ 'elevator'=>'=', 
      #~ 'multi_level'=>'=', 
      #~ 'penthouse'=>'=', 
      #~ 'private_entrance'=>'=', 
      #~ 'back_yard'=>'=', 
      #~ 'gym'=>'=', 
      #~ 'laundry'=>'=', 
      #~ 'dogs_allowed'=>'=', 
      #~ 'cats_allowed'=>'=', 
      #~ 'broadband'=>'=', 
      #~ 'doorman'=>'=', 
      #~ 'rent_stabilized'=>'=',
      #~ 'rent_controlled'=>'=',
      #~ 'convertable'=>'=',
      #~ 'separate_kitchen'=>'=',
      'no_of_balconies'=>'>=',
      'no_of_patios'=>'>=',
      'sq_footage'=>'>=',
      'ceiling_height'=>'>=',
      'appliance_q_id'=>'>=',
      'bathroom_q_id'=>'>=',
      'cellphone_q_id'=>'>=',
      'street_noise_level_id'=>'>=',
      'nbors_noise_level_id'=>'>=',
      'ubound'=>'<=',
      'comment'=>'LIKE'}
      
      conditions_t=[]
      
      # add wildcard characters to LIKE parameter
      params[:listing_info].each {|key,val| params[:listing_info][key] = "%#{val}%" if val != '' && sql_ops[key] == 'LIKE'}
      
      
      
      #pests doesn't work
      #comment doesn't work
      debugger  
      params[:listing_info].delete_if {|key, val| val=="0" || val=="" || key=='pests'}
      
      params[:listing_info] .each {|key, val| conditions_t << "#{key} #{sql_ops[key]||'='} :#{key}"}
      conditions = conditions_t.join(' AND ')
      
        
      @listings = Listing.find(
        :all,
        :joins => [:listing_info, :rent_range],
        :conditions=>[conditions, params[:listing_info]],
        :limit=>20)
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
