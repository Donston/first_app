class BlogPostsController < ApplicationController
  layout "staff"
  before_filter :confirm_logged_in
  #before_filter :find_user
  #before_action :set_blog_post, only: [:show, :edit, :update, :destroy, :list]

  # GET /blog_posts
  def index
    list
    render("list")
  end
  
  def list
    @blog_posts = BlogPost.find(:all, :order => 'blog_posts.created_at ASC')
  end

  def show
    #this action will preview the public view of the posts.
  	@blog_post = BlogPost.find(params[:id])
  	#render(:controller => 'main', :action=> 'view_post')
    @all_categories = Category.find(:all, :order => 'name ASC')
  	render(:template => 'shared/view_post', :layout => 'application')
  end
  alias :view_post :show

  # GET /blog_posts/new
  def new
    @blog_post = BlogPost.new
    @user_list = get_user_list
    @all_categories = get_all_categories  
  end

  # GET /blog_posts/1/edit
  def edit
    @blog_post = BlogPost.find(params[:id])
    @user_list = get_user_list
    @all_categories = get_all_categories  
  end

  # POST /blog_posts
  # POST /blog_posts.json
  def create
    author_id = blog_post_params.delete(:author_id)
    @all_categories = get_all_categories 
	checked_categories = get_categories_from(params[:categories])
	removed_categories = @all_categories - checked_categories
	@blog_post = BlogPost.new(blog_post_params)
	@blog_post.author = User.find(author_id)
	
      if @blog_post.save
        checked_categories.each {|cat| @blog_post.categories << cat if !@blog_post.categories.include?(cat)}
        removed_categories.each {|cat| @blog_post.categories.delete(cat) if @blog_post.categories.include?(cat)}
        redirect_to(:action => "list")
        flash[:notice] = "Blog Post Created."
      else
        @user_list = get_user_list
        render('new')  
    end
  end
  
  def update
   author_id = blog_post_params.delete(:author_id)
   @all_categories = get_all_categories 
	checked_categories = get_categories_from(params[:categories])
	removed_categories = @all_categories - checked_categories
   @blog_post = BlogPost.find(params[:id])
   @blog_post.author = User.find(author_id) if @blog_post.author_id != author_id
      if @blog_post.update_attributes(blog_post_params)
        redirect_to(:action => "show", :id => @blog_post.id)
        checked_categories.each {|cat| @blog_post.categories << cat if !@blog_post.categories.include?(cat)}
        removed_categories.each {|cat| @blog_post.categories.delete(cat) if @blog_post.categories.include?(cat)}
      else
        @user_list = get_user_list
        render('edit')
      end
  end

  def destroy
    BlogPost.find(params[:id]).destroy
    flash[:notice] = "Blog Post Destroyed."
    redirect_to(:action => 'list')
  end

  private # ===================
  
  	def get_user_list
  	  return User.find(:all, :order => "last_name ASC").collect{|user| [user.full_name, user.id]}
  	end
    
    def get_all_categories
      return Category.find(:all, :order => 'name ASC')
    end
    
    def get_categories_from(cat_list)
      cat_list = [] if cat_list.blank?
      return cat_list.collect {|cid| Category.find_by_id(cid.to_i)}.compact
    end
    
    def blog_post_params
      post_params = params.require(:blog_post).permit(:title, :content, :author, :status, :author_id, :created_at, :updated_at, :coments_count)
      return post_params
    end
    # Never trust parameters from the scary internet, only allow the white list through.
   
end
