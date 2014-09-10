class AdminUsersController < ApplicationController
  
  layout 'admin'
  
  before_filter :confirm_logged_in
  
  def index
  	list
  	render('list')
  end
  
  
  def list
  	@admin_users = AdminUser.sorted
  end

  
  def new
  	@admin_user = AdminUser.new
  end
  
  def create
    # Instantiate a new object using form parameters
    @admin_user = AdminUser.new(params.require(:admin_user).permit(:name, :position, :visible, :created_at, :updated_at))
    # Save the object
    if @admin_user.save
      # If save succeeds, redirect to the list action
      flash[:notice] = "Admin user Created."
      redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so user can fix problems
      #@subject_count = Subject.count +1
      render('new')
    end
  end


  def edit
  	@admin_user = AdminUser.find(params[:id])
  end
  
  def update
    # Find object using form parameters
    @admin_user = AdminUser.find(params[:id])
    # Update the object
    if @admin_user.update_attributes(params.require(:admin_user).permit(:first_name, :position, :visible, :created_at, :updated_at))
      # If update succeeds, redirect to the list action
	  flash[:notice] = "Admin User updated."
	  redirect_to(:action => 'list', :id => @admin_user.id)
    else
      # If save fails, redisplay the form so user can fix problems
      #@subject_count = Subject.count +1
      render('edit')
    end
  end
  
  def delete
  	@admin_user = AdminUser.find(params[:id])
  end
  
  def destroy
  	AdminUser.find(parmas[:id].destroy)
  	flash[:notice] = "Admin user destroyed."
  	redirect_to(:action => 'list')
  end
  
end
