class Tourney < ActiveRecord::Base
	has_many :rounds, :dependent => :delete_all
  has_and_belongs_to_many :players
  belongs_to :user
  
  def self.states
    [['new', 0], ['published',1], ['initiated',2], ['finished',3]]
  end
  
  def stateName
    vec = Tourney.states[self.state]
    return vec[0]
  end
end
