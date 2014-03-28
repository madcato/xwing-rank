class Tourney < ActiveRecord::Base
	attr_accessible :titulo
	attr_accesible :state
	has_many :states
end
