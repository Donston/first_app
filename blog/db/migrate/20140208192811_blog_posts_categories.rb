class BlogPostsCategories < ActiveRecord::Migration
  def change
      create_table :blog_posts_categories, :id => false do |t|
      t.integer "blog_post_id"
      t.integer "category_id"
    end
    add_index :blog_posts_categories, ["category_id", "blog_post_id"]
  end
end
