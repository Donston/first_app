class Category < ActiveRecord::Base
  #has_many :categories_posts
  has_and_belongs_to_many :blog_posts
  #, through: :categories_posts
  
  scope :sorted, order('categories.name ASC')
end
