 class PagesController < ApplicationController

  layout 'admin'
  
  before_filter :confirm_logged_in
  before_filter :find_subject

  def index
    list
    render('list')
  end
  
  def list
    @pages = Page.sorted.where(:subject_id => @subject_id)
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
  	#flash[:notice] = ">< #{@subject_id.id}"
    @page = Page.new(:subject_id => @subject_id.id)
    @page_count = @subject_id.pages.size + 1
    flash[:notice] = ">> #{@subject_id.pages.size}"
    #@page_count = Page.count + 1
    @subjects = Subject.order('position ASC')
  end
  
  def create
  	new_position = params[:page].delete(:position)
    # Instantiate a new object using form parameters
    @page = Page.new(params.require(:page).permit(:name, :position, :visible, :permalink, :subject_id))
    # Save the object
    if @page.save
      @page.move_to_position(new_position)
      # If save succeeds, redirect to the list action
      flash[:notice] = "Page created."
      redirect_to(:action => 'list', :subject_id => @page.subject_id)
    else
      flash[:notice] = "Page NOT created."
	  @page_count = @subject_id.pages.size + 1
	  @subjects = Subject.order('position ASC')
      render('new')
    end
  end
  
  def edit
    @page = Page.find(params[:id])
    @page_count = @subject_id.pages.size
    @subjects = Subject.order('positon ASC')
  end
  
  def update
    # Find object using form parameters
    @page = Page.find(params[:id])
    # Update the object
    new_position = params[:page].delete(:position)
    if @page.update_attributes(params.require(:page).permit(:name, :position, :visible, :permalink))
      @page.move_to_position(new_position)
      # If update succeeds, redirect to the list action
      flash[:notice] = "Page updated."
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @page.subject_id)
    else
      # If save fails, redisplay the form so user can fix problems
      flash[:notice] = "Page Not Updated"
	  @page_count = @subject_id.pages.size
      render('edit')
    end
  end
  
  def delete
    @page = Page.find(params[:id])
  end
  
  def destroy
    page = Page.find(params[:id])
    page.move_to_position(nil)
    page.destroy
    flash[:notice] = "Page destroyed."
    redirect_to(:action => 'list', :subject_id => @subject_id)
  end
  
  private
  
  def find_subject
    if params[:subject_id]
      @subject_id = Subject.find_by_id(params[:subject_id])
      flash[:notice] = ">>>> #{params[:subject_id]}"
      flash[:notice] = ">> #{@subject_id.pages.size}"
    end
  end
end
