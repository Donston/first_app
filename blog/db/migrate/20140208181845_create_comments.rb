class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer "blog_post_id", :default => 0, :null => false
      t.string "author", :limit => 25, :default => "", :null => false
      t.string "author_email", :limit => 50, :default => "", :null => false
      t.text "content", :null => false
      t.string "status", :limit => 25, :default => "", :null => false

      t.timestamps
    end
  end
end
