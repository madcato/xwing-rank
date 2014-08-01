class Tourney < ActiveRecord::Base
	has_many :rounds, :dependent => :delete_all
  has_and_belongs_to_many :players
  belongs_to :user
  has_many :rankings
  has_many :matches, through: :rounds
  
  validates :titulo, presence: true
  validates :titulo, length: {minimum: 8} 
  
  def self.states
    ['new', 'published', 'initiated', 'finished']
  end
  
  def stateName
    Tourney.states[self.state]
  end
  
  
  def ranking
    data=Result.joins(match: [round: [:tourney]] ).includes(:player).where(tourneys: {id: self.id}).select('results.player_id').group('results.player_id').sum(:score)
  end
  
  def addPlayerToRanking(player)
    ranking = Ranking.new
    ranking.player = player
    ranking.tourney = self
    ranking.save
  end
  
  def removePlayerFromRanking(player)
    ranking = Ranking.find_by(tourney_id: self.id, player_id: player.id)
    ranking.destroy
  end
  
end
