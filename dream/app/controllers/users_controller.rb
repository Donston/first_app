class UsersController < ApplicationController

    layout('staff')
	def index
	  list
	  render('list')
	end
	
	def list
	  @users = User.find(:all, :order => "created_at ASC")
	end
	
	def manage
	  list
	  if request.get? && params[:id].blank?  #new
	    @user = User.new
	  elsif request.post? && params[:id].blank?  #create
	    @user = User.new(user_params)
	    if @user.save
	      flash[:notice] = "User has been successfully created."
	      redirect_to(:action => 'list')
	    else
	      flash[:notice] = "Failed to create user."
	      redirect_to(:action => 'list')
	    end
	  elsif request.get? && !params[:id].blank?  #edit
	    @user = User.find(params[:id])
	  elsif request.post?  && !params[:id].blank?  #create
	    if params[:commit] == 'Edit'
	      @user = User.find(params[:id])
	      if @user.update_attributes(user_params)
	        flash[:notice] = "User has been successfully created."
	        redirect_to(:action => 'list')
	      else
	        flash[:notice] = "Failed to create user."
	        redirect_to(:action => 'list')
	      end
	    else
	      User.find(params[:id]).destroy  
	      flash[:notice] = "User has been successfully deleted."
	      redirect_to(:action => 'list')
	    end
	  end
	end
	
	 private
  def user_params
    return params.require(:user).permit(:first_name, :last_name, :short_name, :username, :user_level, :hashed_password, :display_name, :email, :created_at, :updated_at, :posts_count)
  end

end