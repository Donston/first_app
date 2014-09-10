class AddCommentCounter < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, :limit => 4, :default => 0, :null => false
    
    Post.all.each do |post|
      Post.reset_counters(post.id, :comments)
    end
  end
end
