class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string "author", :limit => 25, :defualt => "", :null => false
      t.string "author_email", :limit => 40, :default => "", :null => false
      t.text "content", :null => false
      t.string "status", :limit => 25, :default => "new", :null => false
      t.integer "post_id", :default => 0, :null => false 

      t.timestamps
    end
  end
end
