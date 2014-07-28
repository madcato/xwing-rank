class Player < ActiveRecord::Base
  has_and_belongs_to_many :tourneys
  has_many :matches, :foreign_key => :player1_id
end
