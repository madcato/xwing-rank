class Round < ActiveRecord::Base
	attr_accessible :order
	belongs_to :tourney
end
