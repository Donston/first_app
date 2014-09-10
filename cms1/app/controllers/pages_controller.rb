 class PagesController < ApplicationController

  layout 'admin'
  
  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end
  
  def list
    @pages = Page.order("pages.position ASC")
    
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
    @page = Page.new
    @page_count = Page.count + 1
      end
  
  def create
    # Instantiate a new object using form parameters
    @page = Page.new(params.require(:page).permit(:name, :position, :visible, :permalink, :subject_id))
    # Save the object
    if @page.save
      # If save succeeds, redirect to the list action
      flash[:notice] = "Page created."
      redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    # Find object using form parameters
    @page = Page.find(params[:id])
    # Update the object
    if @page.update_attributes(params.require(:page).permit(:name, :position, :visible))
      # If update succeeds, redirect to the list action
      flash[:notice] = "Page updated."
      redirect_to(:action => 'show', :id => @page.id)
    else
      # If save fails, redisplay the form so user can fix problems
       @page_count = Page.count + 1
      render('edit')
    end
  end
  
  def delete
    @page = Page.find(params[:id])
  end
  
  def destroy
    Page.find(params[:id]).destroy
    flash[:notice] = "Page destroyed."
    redirect_to(:action => 'list')
  end
    
end
