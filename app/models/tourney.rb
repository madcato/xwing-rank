class Tourney < ActiveRecord::Base
	has_many :rounds, :dependent => :delete_all
  has_and_belongs_to_many :players
  belongs_to :user
end
