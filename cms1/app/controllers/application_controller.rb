class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  protected
	def confirm_logged_in
		flash[:notice] = "Please log in."
		unless session[:user_id]
		redirect_to(:controller => 'access', :action => 'login')
		return false # halts the before_filter
	   else
	   	return true
	   end
	end 
	
end
