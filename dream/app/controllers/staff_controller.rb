class StaffController < ApplicationController
  
  layout('staff')
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
      flash[:notice] = "You have successfully logged in."
      redirect_to(:action => 'menu')
    else
      flash[:notice] = "Username/password combination incorrect."
      render(:action => 'login')
    end
  end

  def menu
    #just text
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You are now logged out."
    redirect_to(:action => 'login')
  end
end
