class StaffController < ApplicationController
  
  layout "staff"
    before_filter :confirm_logged_in, :except => [:index, :login, :send_login]

  
  def index
    login
    render(:action => 'login')
  end

  def login
    #@user = User.new
  end
  
  def send_login
    found_user = User.authenticate(params[:username], params[:password])
    if found_user
      session[:user_id] = found_user.id
      session[:usernaem] = found_user.username
      flash[:notice] = "You have successfully logged in."
      redirect_to(:action => 'menu')
    else
      flash.now[:notice] = "User/password does not match.  Please make sure your caps lock is off and try again."
      render(:action => 'login')
    end
  end

  def menu
    #just text
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You are now logged out."
    redirect_to(:action => 'login')
  end
end
