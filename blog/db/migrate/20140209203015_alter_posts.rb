class AlterPosts < ActiveRecord::Migration
  def change
    rename_column(:blog_posts, :body, :content)
  end
end
