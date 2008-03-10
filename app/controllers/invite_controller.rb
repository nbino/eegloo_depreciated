class InviteController < ApplicationController
  layout 'main'
  #before_filter :login_required, :only => [:show, :edit, :update]

  def invite
    respond_to do |format|
      format.html { render :layout =>"main" }
      format.xml  { render :xml => @user }
    end
  end
  
   # [EP] [TODO] Leo I can take a crack at this but as we discussed you're much more
   # familiar with the database at this point.  The idea here (take a look at the view,
   # it should be pretty apparent how it works) is that on the invite screen the
   # user gets 2 inputs, (1) a textbox to add emails and (2) a login box to enter 
   # gmail/yahoo/etc info.  Upon entering info in either theres a little box in the
   # view that gets updated with the new contact information, and in this box
   # the user can tick/untick people who should get invites.
   # 
   # if @contacts was a persistent variable, the following code would work.  Of course
   # it's not that easy, so we'll have to store the stuff in a DB, the record being
   # {name, email, send?}, and then flush this db after the user hits send.
   

  def get  
    
    require "contacts"
		login = params[:invite][:login]
		password = params[:invite][:password]
		Contacts.new(params[:invite][:service], login, password).contacts.each { |c| 
		  @contacts << Invite.new({:name => c[0], :email => c[1]})
		}
		render :partial=>'contact', :collection => @contacts
  end
  
  
  def add
    
    @contacts << Invite.new({:name => '', :email => params[:invite][:email]})
    render :partial=>'contact', :collection => @contacts
  end
  
end
