class Subject < ActiveRecord::Base
	
	has_many :pages
	
	validates_presence_of :name		#Error if :name is blank.
	validates_length_of :name, :maximum => 255
	
	
	scope :visible, where(:visible => true)
	scope :invisible, where(:visible => false)
	scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}
end
