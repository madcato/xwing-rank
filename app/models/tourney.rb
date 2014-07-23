class Tourney < ActiveRecord::Base
	has_many :rounds, :dependent => :delete_all
  has_and_belongs_to_many :players
  belongs_to :user
  
  def self.states
    ['new', 'published', 'initiated', 'finished']
  end
  
  def stateName
    Tourney.states[self.state]
  end
end
