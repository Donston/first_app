class AddCommentCounter < ActiveRecord::Migration
  def change
    add_column "posts", :comments_count, :integer, :limit => 4, :default => 0, :null => false
    add_column "users", :posts_count, :integer, :limit => 4, :default => 0, :null => false
    
    Post.find(:all).each do |post|
     current_count = post.comments.length
    post.update_attribute(:comments_count, current_count)
   end
  end
end
