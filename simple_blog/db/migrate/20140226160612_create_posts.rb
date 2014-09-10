class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string "title", :limit => 100, :default => "", :null => false
      t.text "content",:null => false
      t.string "author", :limit => 100, :default => 0, :null => false
      t.string "status", :limit => 20, :default => "", :null => false
      t.integer "author_id", :default => 0, :null => false

      t.timestamps
    end
    #Post.create(:title => "First Blog", :body => "Poo Face Maggie", :author => "Mr. X", :status => "new")
  end
  
end
