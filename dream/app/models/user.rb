require "digest/sha1"

class User < ActiveRecord::Base
  
  has_many :posts, :foreign_key => 'author_id'
  has_many :recent_posts, :class_name => "Post", 
                          :limit => 5,
                          :order => "created_at ASC"
  
  attr_accessor :password
  
  #validates_presence_of :username, :password
  validates_uniqueness_of :username
  #validates_length_of :password, :within => 8..25, :on => create
  
  before_save :create_hashed_password
  after_save :clear_password
                          
  def full_name
    return self.first_name + " " + self.last_name
  end
  
  def self.authenticate(username="", password="")
  	user = User.find_by_username(username)
  	if user && user.password_match?(password)
  		return user
  	else
  		return false
  	end
  end
  
  def password_match?(password)  #returning a boolean value.
    hashed_password == User.hash_with_salt(password, salt)
  end
  
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  
  private #-------------------------------------------------
  
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
