class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string "title", :limit => 100, :default => "", :null => false
      t.text "body",:null => false
      t.string "author", :limit => 100, :default => 0, :null => false
      t.string "status", :limit => 20, :default => "", :null => false
      t.integer "author_id", :default => 0, :null => false

      t.timestamps
    end
    #BlogPost.create(:title => "First Blog", :body => "Poo Face Maggie", :author => "Mr. X", :status => "new")
  end
  
end
