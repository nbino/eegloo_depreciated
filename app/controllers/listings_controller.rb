class ListingsController < ApplicationController
  verify :session => :user, :redirect_to => { :controller => :admin, :action => :login }
  
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  def index
    list
    render :action => 'list'
  end

  def list_debug
    #@favorites = Listing.find_favorites session[:user].id
    @favorites = session[:user].favorites
    @listings = Listing.find :all
    #Flag
    #BogusFlag.create(:user_id => 1, :listing_id => 1, :description=>"")
    #@listings.find(:id => 1).bogus_flags.create ()
    
    render :partial => "search_results"
  end
  
  def list
    #@favorites = Listing.find_favorites session[:user].id
    AttributeValue
    @favorites = session[:user].favorites
    @listings = {}
    
    # hack for empty databases, need to fix
    @listing = session[:user].listings[0] || Listing.new
    
    
  end

  def create
    session[:user].listings.create params[:listing]
  end

  def flag_bogus
    Flag
    @listing = Listing.find(params[:id])
    @listing.bogus_flags.create! :user_id=>session[:user].id
  end
  
  def flag_n_a
    Flag
    @listing = Listing.find(params[:id])
    @listing.n_a_flags.create! :user_id=>session[:user].id
  end
  
  def flag_broker
    Flag
    @listing = Listing.find(params[:id])
    @listing.broker_flags.create! :user_id=>session[:user].id
  end
  
  def update
    session[:user].listings.update params[:id], params[:listing]
  end
  
  def add_visual
    session[:user].listings[0].visuals.create params[:visual]
    @listing = session[:user].listings[0]
    
    responds_to_parent do
      render :update do |page|
        page.replace_html 'visuals_list', :partial => 'visuals_list'
      end
    end
    
  end
  

  def destroy_visual
    Visual.find(params[:id]).destroy
  end
  
  def destroy_favorite
    #need to fix for counter cache
    #session[:user].favorites[].destroy
    Favorite.find(params[:id]).destroy
    @favorites = session[:user].favorites
  end
  
  def add_favorite
    Favorite.create(:user_id => session[:user].id, :listing_id => params[:listing], :description => "very cool")
    @favorites = session[:user].favorites
  end
  
  def do_search
    Flag
    params[:search].delete_if {|key, value| value == "" || value == "0"}
    @listings = Listing.find(:all, :conditions => params[:search], :include => [ :nhood, :rent_range, :apt_type])
  end
  
end
