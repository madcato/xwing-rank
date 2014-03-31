class Tourney < ActiveRecord::Base
	has_many :rounds, :dependent => :delete_all
end
