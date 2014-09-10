class AdminUsersController < ApplicationController
  
  layout 'admin'
  
  before_filter :confirm_logged_in
  
  def index
  	list
  	render('list')
  end

  def list
  	@admin_users = AdminUser.order("admin_users.last_name ASC, admin_users.first_name ASC")
  end

  def new
  	@admin_users = AdminUser.new
  end

  def create
  	@admin_user = AdminUser.new(params.require(:admin_user).permit(:first_name, :last_name, :username, :email, :password, :created_at, :updated_at, :salt, :hashed_password))
    # Save the object
    if @admin_user.save
      # If save succeeds, redirect to the list action
      flash[:notice] = "Admin user created."
      redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so user can fix problems
      @admin_user = AdminUser.count +1
      flash[:notice] = "Admin user pooed."
      render('new')
    end
  end

  def edit
  	@admin_user = AdminUser.find(params[:id])
  	#@admin_user_count = AdminUser.count
  end

  def update
  	# Find object using form parameters
    @admin_user = AdminUser.find(params[:id])
    # Update the object
    if @admin_user.update_attributes(params.require(:admin_user).permit(:name, :position, :visible, :created_at, :updated_at))
      # If update succeeds, redirect to the list action
	  flash[:notice] = "Admin User Updated."
	  redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so user can fix problems
      #@admin_user_count = AdminUser.count +1
      render('edit')
    end
  end

  def delete
  	@admin_user = AdminUser.find(params[:id])
  end

  def destroy
  	#@admin_user = 
  	AdminUser.find(params[:id]).destroy
    flash[:notice] = "Admin User Deleted."
	redirect_to(:action => 'list')
  end
  
end
