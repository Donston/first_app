class Post < ActiveRecord::Base
 
  belongs_to :author, :class_name => "User",
                      :foreign_key => "author_id",
                      :counter_cache => true
  has_many :approved_comments, :class_name => 'Comment',
           :conditions => "comments.status = 'approved'"
  has_many :comments, :dependent => :destroy
  has_and_belongs_to_many :categories
  
end
