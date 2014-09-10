class PostsController < ApplicationController
  
  layout("staff")
  
  def index
    list
    render("list")  
  end
  
  def list
    @post = Post.find(:all, :order => "posts.created_at ASC")
  end
  
  def create
    author_id = posts_params.delete(:author_id)
    @all_categories = get_categories_list
    checked_categories = get_categoriest_from(params[:category])
    removed_categories = @all_categories - checked_categories
    @post = Post.new(posts_params)
    @post.author = User.find(author_id)
      if @post.save
        checked_categories.each {|cat| @post.categories << cat if !@post.categories.include?(cat)}
        removed_categories.each {|cat| @post.categories.delete(cat) if @post.categories.include?(cat)}
        flash[:notice] = "Post Created."
        redirect_to(:action => "list")
      else
        @user_list = get_user_list
        render("new")
      end
  end
  
  def edit
    @post = Post.find(params[:id])
    @user_list = get_user_list
    @all_categories = get_categories_list    
  end

  def update
    author_id = posts_params.delete(:author_id)
    @all_categories = get_categories_list
    checked_categories = get_categoriest_from(params[:category])
    removed_categories = @all_categories - checked_categories
    @post = Post.find(params[:id])
    @post.author = User.find(author_id) if @post.author_id != author_id
      if @post.update_attributes(posts_params)
        checked_categories.each {|cat| @post.categories << cat if !@post.categories.include?(cat)}
        removed_categories.each {|cat| @post.categories.delete(cat) if @post.categories.include?(cat)}
        flash[:notice] = "Post was successfully updated."
        redirect_to(:action => "show", :id => @post)
      else
        @user_list = get_user_list
        render("edit")
      end
  end


  def new
    @post = Post.new
    @user_list = get_user_list
    @all_categories = get_categories_list    
  end
  
  
  def show
    #this actin will preview the public view of the post
    @post = Post.find(params[:id])
    @all_categories = get_categories_list
    render(:template => 'shared/view_post', :layout => 'main')
  end
  alias :view_post :show
  
  def destroy
    Post.find(params[:id]).destroy
    flash[:notice] = "Blog Post Destroyed."
    redirect_to(:action => 'list')
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
  
  private #============================================
  
  def posts_params
     return params.require(:post).permit(:title, :content, :author, :status, :author_id, :created_at, :updated_at, :coments_count)
  end
  
  def get_user_list
    return User.find(:all, :order => "last_name ASC").collect {|user| [user.full_name, user.id]}
  end
  
  def get_categories_list
    return Category.find(:all, :order => "name ASC")
  end
  
  def get_categoriest_from(cat_list)
    cat_list = [] if cat_list.blank?
    return cat_list.collect {|cid| Category.find_by_id(cid.to_i)}.compact
  end
  
  def comments_params
    return params.require(:comment).permit(:post_id, :author, :author_email, :content, :status, :created_at, :updated_at)  
  end
    
end
