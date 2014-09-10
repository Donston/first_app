class MainController < ApplicationController
  def index
    list
    render(:action => 'list')
  end
  
  def list
    @posts = Post.find(:all, :include =>   [:author, :categories, :approved_comments],
                       :conditions => "status = 'published'",
                       :order => "created_at DESC")
  end
  
  def category
  end
  
  def archive
  end

  def view_post
    @post = Post.find(params[:id], :include => [:author, :categories, :approved_comments])
    @comment = Comment.new
    render(:template => 'shared/view_post')
  end
  
  def add_comment
    @comment = Comment.new(comments_params)
    @post = Post.find(params[:id])
    @comment.post = @post
    if @comment.save
      flash[:notice] = "Your comment has been successfully submitted."
      redirect_to(:action => 'view_post', :id => @post.id)
    else
      render(:template => 'shared/view_post')
    end
  end
  
  private #================================================================
  def comments_params
    return params.require(:comment).permit(:post_id, :author, :author_email, :content, :status, :created_at, :updated_at)  end
end
