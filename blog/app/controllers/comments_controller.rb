class CommentsController < ApplicationController
  
  layout "staff"
  before_filter :confirm_logged_in

  
  def index
  list
  render('list')
  end
  
  def list
    case params[:status]
      when 'approved'
        @comments = Comment.find(:all, :conditions => "status = 'approved'", :order => 'created_at DESC')
      when 'spam'
        @comments = Comment.find(:all, :conditions => "status = 'spam'", :order => 'created_at DESC')
      when 'all'
        @comments = Comment.sorted 
      else # 'new'
        @comments = Comment.find(:all, :conditions => "status = 'new'", :order => 'created_at DESC')
    end
  end

  def show
    #flash[:notice] = "111"
    @comment = Comment.find(params[:id])
  end
  
  def set_status
    begin
      status = params[:commit] || ""
      checked_items = params[:commentlist]
      checked_items.each do |id|
        Comment.update(id.to_i, :status => status.downcase)
      end
      flash[:notice] = "The checked items have been updated."
      redirect_to(:action => 'list')
    rescue
      flash[:notice] = "An unknown error occured."
      redirect_to(:action => 'list')
    end
  end
  
end
