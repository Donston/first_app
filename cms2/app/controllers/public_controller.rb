class PublicController < ApplicationController

  layout 'public'
  
  before_filter :setup_navigation
  before_filter :find_subject
  
  def index
    # intro text
  end

  def show
    @page = Page.where(:permalink => params[:id], :visible => true).first
    #redirect_to(:action => 'index') unless @page
  end

  private
  
  def setup_navigation
    @subjects = Subject.visible.sorted
  end
  
  private
  def find_subject
    if params[:subject_id]
      @subject_id = Subject.find_by_id(params[:subject_id])
      flash[:notice] = ">>>> #{params[:subject_id]}"
    end
  end
  
end
