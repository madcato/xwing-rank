class Round < ActiveRecord::Base
	belongs_to :tourney
	has_many :matches, :dependent => :destroy
  
  validates :order, presence: true
  validate :orderValue
  
  before_validation :setCorrectOrder
  
  default_scope { order('2 ASC') }
  
  
  
  def isFirstRound?
    self.order == 1
  end
  
  def seedRound
    if self.isFirstRound?
      self.seedFirstRound
    else
      self.seedNormalRound
    end
  end


  def seedFirstRound
    # Create pairings using random method
    players = self.tourney.players
    players = players.map.to_a
    
    # First assign a match to each player with a bye
    for index in 0..self.tourney.rankings.count-1
      ranking = self.tourney.rankings[index]
      if ranking.bye
        match = Match.new
        match.player1 = ranking.player  
        match.points1 = 100
        match.points2 = 0
        match.round = self
        match.save
        players.delete(ranking.player)
      end
    end
    
    while players.count > 0
      index = rand(players.count)
      player1 = players.delete_at(index)
      match = Match.new
      match.player1 = player1
      if (players.count == 0)
        match.player2 = nil
      else
        index = rand(players.count)
        player2 = players.delete_at(index)
        match.player2 = player2
      end
      checkBye(match)
      match.round = self
      match.save
    end
  end
  
  def checkBye(match)
    if !match.player1.nil? and match.player2.nil?
      match.points1 = 50
    end
  end
  
  def seedNormalRound
    # Create pairings using one by one method
    players = self.tourney.rankings.map(&:player).to_a
    while !players.empty?
      player1 = players.shift
      player2 = players.shift
      tempPlayers = []
      while checkRepeated(player1,player2) and !players.empty?
        # Put other player2
        tempPlayers << player2
        player2 = players.shift
      end
      if tempPlayers.count != 0 
        players = tempPlayers + players
      end
      match = Match.new
      match.player1 = player1
      match.player2 = player2
      match.round = self
      checkBye(match)
      match.save
    end
  end
  
  def checkRepeated(player1,player2)
    match = self.tourney.matches.find_by(player1_id: player1, player2_id: player2)
    return true unless match.nil?
    match = self.tourney.matches.find_by(player1_id: player2, player2_id: player1)
    return true unless match.nil?
    
    return false
  end
  
private
  def orderValue
    if !self.order.nil? and self.order <= 0
      errors.add(:points1, "El orden debe ser un número positivo mayor o igual a 1.")
    end
  end
  
  def setCorrectOrder
    if self.tourney.rounds.count == 0
      self.order = 1
    else
      lastRound = self.tourney.rounds.maximum(:order)
      self.order = lastRound + 1
    end
  end
end
