class Match < ActiveRecord::Base
	belongs_to :round
  belongs_to :player1, :class_name => :Player
  belongs_to :player2, :class_name => :Player 

  after_create :addRankings
  before_update :removeRankings
  after_update :addRankings
  before_destroy :removeRankings

  validate :pointsValues
  validate :playersAreDifferent
  validates :player1, presence: true
  # player2 == nil means that player1 receives a bye
  
  def self.possibleResults
    [0,1,3,5]
  end
  
  private
    def update_rankings
      winProb1 = EloHelper.calculateWinProb(self.player1.ranking, self.player2.ranking)
      winProb2 = EloHelper.calculateWinProb(self.player2.ranking, self.player1.ranking)
    	win1 = 0.5
      win2 = 0.5
    	win1 = 1 if self.winner == 1
    	win1 = 0 if self.winner == 2
    	win2 = 0 if self.winner == 1
    	win2 = 1 if self.winner == 2
    	self.player1.ranking = EloHelper.calculateNewRanking(self.player1.ranking, winProb1, win1)
    	self.player2.ranking = EloHelper.calculateNewRanking(self.player2.ranking, winProb2, win2)
    	self.player1.save
    	self.player2.save
    end
    
    def addRankings
      return if self.points1.nil?
      return if self.points2.nil?
      
      addRankingForPlayer(self.player1,self.points1,self.points2,self.player2) 
      addRankingForPlayer(self.player2,self.points2,self.points1,self.player1) unless self.player2.nil?
    end
    
    def addRankingForPlayer(player,playerPoints, opponentPoints,opponent)
      difference,breakpoints,winner,modifiedWin,draw = calculateResults(player,playerPoints, opponentPoints,opponent)      
      
      ranking = Ranking.find_by(player_id: player.id, tourney_id: self.round.tourney.id)
      ranking.breakpoints += breakpoints
      ranking.points += pointsEarned(winner,modifiedWin,draw)
      ranking.save
    end
    
    def pointsEarned(winner,modifiedWin,draw)
      return 1 if draw
      return 0 unless winner
      return 3 if modifiedWin
      return 5
    end

    def removeRankings
      
      prevMatch = Match.find(self.id)
      return if prevMatch.points1.nil?
      return if prevMatch.points2.nil?
      
      removeRankingForPlayer(prevMatch.player1,prevMatch.points1,prevMatch.points2,prevMatch.player2)
      removeRankingForPlayer(prevMatch.player2,prevMatch.points2,prevMatch.points1,prevMatch.player1) unless prevMatch.player2.nil?
    end
    
    def removeRankingForPlayer(player,playerPoints, opponentPoints,opponent)
      difference,breakpoints,winner,modifiedWin,draw = calculateResults(player,playerPoints, opponentPoints,opponent)
      
      ranking = Ranking.find_by(player_id: player.id, tourney_id: self.round.tourney.id)
      ranking.breakpoints -= breakpoints
      ranking.points -= pointsEarned(winner,modifiedWin,draw)
      ranking.save
    end
    
    def calculateResults(player,playerPoints, opponentPoints,opponent)
      difference = playerPoints - opponentPoints
      breakpoints = 100 + difference
      winner = false
      winner = true if playerPoints > opponentPoints
      modifiedWin = false
      modifiedWin = true if difference < 12
      draw = false
      draw = true if difference == 0
      return [difference,breakpoints,winner,modifiedWin,draw]
    end
    
    def pointsValues
      if !self.points1.nil? and self.points1 < 0
        errors.add(:points1, "El valor no puede ser menor que cero.")
      end
      if !self.points2.nil? and self.points2 < 0
        errors.add(:points2, "El valor no puede ser menor que cero.")
      end
    end
    
    def playersAreDifferent
      return if self.player1.nil?
      return if self.player2.nil?
      if self.player1 == self.player2 
        errors.add(:player2,"Los jugadores deben ser diferentes")
      end
    end
end
