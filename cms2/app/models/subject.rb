require 'position_mover'

class Subject < ActiveRecord::Base
	
	include PositionMover
		
	has_many :pages
	
	validates_presence_of :name		#Error if :name is blank.
	validates_length_of :name, :maximum => 255
	
	
	scope :visible, where(:visible => true)
	scope :invisible, where(:visible => false)
	scope :sorted, order('subjects.position ASC')
	scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}
end
