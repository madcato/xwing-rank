class Round < ActiveRecord::Base
	belongs_to :tourney
	has_many :matches, :dependent => :delete_all
end
