class User < ActiveRecord::Base
  has_many :posts, :foreign_key => "author_id"
  #, :order => "created_at ASC"
  has_many :recent_posts, :class_name => "Blog_Post", :limit => 5
  
  def full_name
    self.first_name + "" + self.last_name
  end
end
