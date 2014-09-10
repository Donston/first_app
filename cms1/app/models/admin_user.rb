require 'digest/sha1'

class AdminUser < ActiveRecord::Base
  
  # To configure a different table name
  # set_table_name("admin_users")
  
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits
  
  #EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  validates :first_name, :presence => true, :length => { :maximum => 25 }
  validates :last_name, :presence => true, :length => { :maximum => 50 }
  validates :username, :length => { :within => 8..25 }, :uniqueness => true
  #validates :email, :presence => true, :length => { :maximum => 100 }, 
   # :format => EMAIL_REGEX, :confirmation => true
  
  scope :named, lambda {|first,last| where(:first_name => first, :last_name => last)}
  scope :sorted, order("admin_users.last_name ASC, admin_user.first_name ASC")
  
  def name
  	"#{first_name} #{last_name}"
  end
    
  def self.authenticate(username="", password="")
  	user = AdminUser.find_by_username(username)
  	if user && user.password_match?(password)
  		return user
  	else
  		return false
  	end
  end
  
  def password_match?(password="")
  	hashed_password == AdminUser.hash_with_salt(password, salt)
  end
  
  def self.make_salt(username="")
  	Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end 
  
  def self.hash_with_salt(password="", salt="")
  	Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  
end
