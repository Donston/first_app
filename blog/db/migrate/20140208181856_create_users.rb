class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "username", :limit => 25, :default => "", :null => false
      t.string "hashed_password", :limit => 40, :default => "", :null => false
      t.string "first_name", :limit => 25, :default => "", :null => false
      t.string "last_name", :limit => 40, :default => "", :null => false
      t.string "email", :limit => 50, :default => "", :null => false
      t.string "display_name", :limit => 25, :default => "", :null => false
      t.integer "user_level", :limit => 3, :default => 0, :null => false

      t.timestamps
    end
    User.create(:username => "donston28", :hashed_password => "password", :first_name => "John", :last_name => "De Leon", :email => "jdeleon@xyz.com", :display_name => "Donston", :user_level => 9)
  end
end
