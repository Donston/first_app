class Category < ActiveRecord::Base
  #has_many :categories_posts
  has_and_belongs_to_many :posts
  #, through: :categories_posts
end
