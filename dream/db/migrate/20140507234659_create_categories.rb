class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string "name", :limit => 40, :default => "", :null => false
      t.string "short_name", :limit => 25, :default => "", :null => false
      t.string "description", :default => "", :null => false
      t.timestamps
    end
  end
end
