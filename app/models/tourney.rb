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
  
  def addPlayerToRanking(player,bye)
    ranking = Ranking.new
    ranking.player = player
    ranking.tourney = self
    ranking.bye = bye
    ranking.save
  end
  
  def removePlayerFromRanking(player)
    ranking = Ranking.find_by(tourney_id: self.id, player_id: player.id)
    ranking.destroy
  end
  
  def calculateSOS
    self.rankings.each {|ranking| 
      ranking.sos = calculateSOSFor(ranking.player)
      ranking.save
    }
  end

  def calculateSOSFor(player)
    playerMatches = self.matches.where(:player1 => player)
    sos = 0
    playerMatches.each {|match| 
      unless match.player2.nil?
        ranking = self.rankings.find_by(player_id: match.player2)
        sos += ranking.points
      end
    }
    
    playerMatches = self.matches.where(:player2 => player)
    playerMatches.each {|match| 
      unless match.player1.nil?
        ranking = self.rankings.find_by(player_id: match.player1)
        sos += ranking.points
      end
    }
    return sos
  end
  
end
