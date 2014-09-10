class AddPostCounter < ActiveRecord::Migration
  def change
    add_column :users, :posts_count, :integer, :default => 0, :limit => 4, :null => 0
    
    User.all.each do |user|
      User.reset_counters(user.id, :posts)
    end
  end
end
