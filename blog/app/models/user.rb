class User < ActiveRecord::Base
  has_many :blog_posts, :foreign_key => "author_id"
  #, :order => "created_at ASC"
  has_many :recent_posts, :class_name => "Blog_Post", :limit => 5
  #checks if there is no other same username in database.
  validates_uniqueness_of :username
  
  
  scope :sorted, order('users.first_name ASC')
  
  attr_accessor :password
  
  before_save :create_hashed_password
  after_save :clear_password
  #attr_accessible :first_name, :last_name, :email, :display_name, :user_level, :username, :password
  #attr_protected :hashed_password, :salt
  
  def full_name
    self.first_name + "" + self.last_name
  end  
  
  def self.authenticate(username="", password="")
  	user = User.find_by_username(username)
  	if user && user.password_match?(password)
  		return user
  	else
  		return false
  	end
  end
  
  def password_match?(password="")
  	hashed_password == User.hash_with_salt(password, salt)
  end
  
  def self.make_salt(username="")
  	Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password="", salt="")
	Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  
  
  private #==============================
  
  def create_hashed_password
  	# Whenever :password has a value hashing is needed.
  	unless password.blank?
  		#Always use "self" when assigning values
  		self.salt = User.make_salt(username) if salt.blank?
  		self.hashed_password = User.hash_with_salt(password, salt)
  		end
  	end
  
  def clear_password
  	self.password = nil
  end

end