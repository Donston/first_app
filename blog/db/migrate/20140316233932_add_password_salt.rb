class AddPasswordSalt < ActiveRecord::Migration
  def change
    add_column "users", :salt, :string, :limit => 40
    #You should make this irreversable or else you will lose your Users passwords.
    users = User.find(:all)
      users.each do |user|
        user.password = user.hashed_password
        user.save
      end
  end
end
