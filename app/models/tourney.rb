class Tourney < ActiveRecord::Base
	has_many :rounds, :dependent => :delete_all
  has_and_belongs_to_many :players
  belongs_to :user
  has_many :rankings, :dependent => :delete_all
  has_many :matches, through: :rounds
  
  validates :titulo, presence: true
  validates :titulo, length: {minimum: 8} 
  validates :seedType, presence: true
  validates :seedType, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }
  
  before_create :initPublicId
  
  def self.states
    [I18n.t('new'), I18n.t('published'), I18n.t('initiated'), I18n.t('finished')]
  end
  
  def stateName
    Tourney.states[self.state]
  end
  
  def lastRound
    self.rounds.last
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
  
  
  def startEliminationRounds(numberOfPLayers)
    return if self.mode == 2 # Tourney already in Elimination mode
    
    self.mode = 2
    self.save
    
    self.rankings.each { |ranking|
      ranking.eliminated = true
    }
    
    i = 0
    while i < numberOfPlayers
      self.rankings[i].eliminated = false
      i += 1
    end
    
    self.rankings.save
  end
private 
  def initPublicId
    o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    self.publicId = (0...10).map { o[rand(o.length)] }.join
  end  
end
