class CategoriesController < ApplicationController
  
  layout "staff"
  before_filter :confirm_logged_in
  
  def index
    list
    render('list')
  end
  
  def list
    @categories = Category.sorted
    @category = Category.find(params[:id]) if params[:id]
    @category = Category.new if @category.nil?
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category was succesfuly created.'
      redirect_to(:action => 'list')
    else
      render :action => 'list'
    end
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:notice] = 'Category was successfully updated.'
      redirect_to(:action => 'list')
    else
      render(:action => 'list')
    end
  end
  
  def destroy
    Category.find(params[:id]).destroy
    flash[:notice] = "Category Destroyed."
    redirect_to(:action => 'list')
  end
  
  private
  
  def category_params
    category_params = params.require(:category).permit(:name, :short_name, :description, :created_at, :updated_at)
    return category_params
  end

end