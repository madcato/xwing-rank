class Match < ActiveRecord::Base
	belongs_to :round
	belongs_to :player1, :class_name => :player
	belongs_to :player2, :class_name => :player  
end
