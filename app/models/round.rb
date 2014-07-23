class Round < ActiveRecord::Base
	belongs_to :tourney
	has_many :matches, :dependent => :delete_all
  
  validates :order, presence: true
  validates :order, uniqueness: true
  
  default_scope { order('2 ASC') }
end
