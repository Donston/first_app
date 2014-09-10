class CategoriesController < ApplicationController
  layout("staff")
  def index
    list
    render('list')
  end
  
  def list
    @categories = Category.find(:all, :order => "name ASC")
    @category = Category.find(params[:id]) if params[:id]
    @category = Category.new if @category.nil?
  end

  def edit
  end
  
  def create
    @category = Category.new(params_category)
    if @category.save
      flash[:notice] = "Categroy was successfully created."
      redirect_to(:action => "list")
    else
      flash[:notice] = "Failed to create category."
      render("list")
    end
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params_category)
      flash[:notice] = 'Category was successfully updated.'
      redirect_to(:action => "list")
    else
      render("list")
    end
  end
  
  def destroy
    @category = Category.find(params[:id]).destroy
    redirect_to(:action => 'list')
  end
  
  private
  def params_category
    return params.require(:category).permit(:name, :short_name, :description, :created_at, :updated_at)
  end
end
