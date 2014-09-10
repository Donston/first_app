class UsersController < ApplicationController
  
  layout "staff"
  before_filter :confirm_logged_in
  
  def index
    list
    render :action => 'list'
  end

  def list
    @users = User.sorted
    #@user = User.find(params[:id])
  end

  def manage
    list
    if request.get? && params[:id].blank? #new
      @user = User.new
      flash[:notice] = "I will murder you!"
    elsif request.post? && params[:id].blank? #create
      @user = User.new(user_params)
	  if @user.save
	    flash[:notice] = "User was succefully created."
	    redirect_to(:action => 'list')
      else
        render(:action => 'manage')    
      end
    elsif request.get? && !params[:id].blank? #edit
      @user = User.find(params[:id])
    elsif request.post? && !params[:id].blank? #update or delete
      if params[:commit] == 'Edit'
	      @user = User.find(params[:id])
	      if @user.update_attributes(user_params)
	        flash[:notice] = "User was succesffuly updated."
	        redirect_to({:action => 'list'})
	      else
	         render(:action => 'edit')
	      end
	  else #action should delete
	      #flash[:notice] = "FAIL :P"
	      @user = User.find(params[:id])
	      @user.destroy
	      flash[:notice] = "User was succefully deleted."
	      redirect_to(:action => 'list')
	      #flash[:notice] = "FAIL :P"
	  end
    end
  end  
 
 private
  
  def user_params
    user_params = params.require(:user).permit(:first_name, :last_name, :display_name, :username, :password, :email, :user_level, :created_at, :updated_at, :blog_posts_count)
    return user_params
  end 
end
