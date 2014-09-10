class SectionsController < ApplicationController

  layout 'admin'
  
  before_filter :confirm_logged_in
  before_filter :find_page

  def index
    list
    render('list')
  end
  
  def list
    @sections = Section.sorted.where(:page_id => @page_id.id)
  end
  
  def show
    @section = Section.find(params[:id])
  end
  
  def new
    @section = Section.new(:page_id => @page_id.id)
    @section_count = @page_id.sections.size + 1
    @pages = Page.order('position ASC')
  end
  
  def create
    @section = Section.new(params.require(:section).permit(:name, :position, :visible, :content, :content_type, :page_id))
    if @section.save
      flash[:notice] = "Section created."
      redirect_to(:action => 'list', :page_id => @page_id.id)
    else
      @section_count = @page_id.sections.size + 1
      @pages = Page.order('position ASC')
      render('new')
    end
  end
  
  def edit
    @section = Section.find(params[:id])
    @section_count = @page_id.sections.size
    @pages = Page.order('position ASC')
  end
  
  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(params.require(:section).permit(:name, :position, :visible, :content, :content_type, :page_id))
      flash[:notice] = "Section updated."
      redirect_to(:action => 'show', :id => @section.id)
    else
      @section_count = @page_id.sections.size
      @pages = Page.order('position ASC')
      render('edit')
    end
  end
  
  def delete
    @section = Section.find(params[:id])
  end
  
  def destroy
    Section.find(params[:id]).destroy
    flash[:notice] = "Section destroyed."
    redirect_to(:action => 'list', :page_id => @page_id)
  end
  
  private
  def find_page
  	if params[:page_id]
  		@page_id = Page.find_by_id(params[:page_id])
  		flash[:notice] = ">> #{params[:page_id]}"
  	end
  end
    
end
