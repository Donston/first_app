class BlogPost < ActiveRecord::Base
  belongs_to :author, :class_name => "User", 
  					  :foreign_key => "author_id",
  					  :counter_cache => true
  
  has_many :comments, :dependent => :destroy
  has_many :approved_comments, :class_name => 'Comment',
           :conditions => "comments.status = 'approved'"
  has_and_belongs_to_many :categories
  
  #scope :sorted, order('blog_posts.created_at ASC')
  #def approved_comments
    #self.comments.find(:all, :conditions => "status = 'approved'")
  #end
end

