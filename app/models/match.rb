class Match < ActiveRecord::Base
	belongs_to :round
	has_many :results
  
  def self.possibleResults
    [0,1,3,5]
  end
  
#  data=Result.joins(match: [round: [:tourney]] ).where(tourneys: {id: 1}).select('results.player_id').group('results.player_id').sum(:score)
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

end
