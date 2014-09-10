class AccessController < ApplicationController
  
  layout 'admin'
  
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
  def index
  	menu
  	render('menu')
  end
  
  def menu
  
  end

  def login
  
  end
  
  def attempt_login
  	authorized_user = AdminUser.authenticate(params[:username], params[:password])
  	if authorized_user
  		session[:user_id] = authorized_user.id
  		session[:user_name] = authorized_user.username
  		flash[:notice] = "You are now logged in."
  		redirect_to(:action => 'menu')
  	else
  		flash[:notice] = "Invalid username/password."
  		redirect_to(:action => 'login')
  	end
  end
  
  def logout
  	session[:user_id] = nil
  	session[:user_name] = nil

  	flash[:notice] = "You have been logged out."
  	redirect_to(:action => 'menu')
  end
  
end
