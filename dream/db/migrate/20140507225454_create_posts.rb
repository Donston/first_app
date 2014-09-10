class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string "title", :limit => 100, :default => "", :null => false
      t.string "author", :limit => 40, :default => "", :null => false
      t.text "content", :null => false
      t.string "status", :limit => 20, :default => "new", :null => false
      t.integer "author_id", :default => 0, :null => "null"
      t.timestamps
    end
  end
end
