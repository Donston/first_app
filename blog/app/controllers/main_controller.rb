class MainController < ApplicationController
  
  layout 'main'
  
  before_filter :set_all_categories
  
  def index
    list
    render(:action => 'list')
  end

  def list
    @blog_posts = BlogPost.find(:all, :include => [:author, :categories, :approved_comments],
    	:conditions => "blog_posts.status = 'published'",
    	:order => 'blog_posts.created_at DESC')
  end

  def category
  end

  def archive
  end

  def view_post
    @blog_post = BlogPost.find(params[:id], :include => [:author, :categories, :approved_comments])
    @comment = Comment.new
    render(:template => 'shared/view_post')
    
  end
  
  def add_comment
    @comment = Comment.new(comment_params)
    @blog_post = BlogPost.find(params[:id])
    @comment.blog_post = @blog_post
    @comment.status = "new"
    if @comment.save
      flash[:notice] = "Your comment was submitted succesfully."
      redirect_to(:action => 'view_post', :id => @blog_post.id)
    else
      render(:template => 'shared/view_post')
    end   
  end
  
  private
  def comment_params
    comment_params = params.require(:comment).permit(:blog_post_id, :author, :author_email, :content, :status, :created_at, :updated_at)
    return comment_params
  end
  
  def set_all_categories
    @all_categories = Category.find(:all, :order => 'name ASC')
  end
end
