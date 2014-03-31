module EloHelper
  K = 32.0
  def EloHelper.calculateWinProb(rankingPlayer, rankingOpponent)
    diff = rankingOpponent - rankingPlayer
    return 1.0 / (1.0 + (10 ** (diff/400.0)))
  end
  # playerWinner = 1 if player wins, playerWinner = 0 if player losts, playerWinner = 0.5 if drawes
  def EloHelper.calculateNewRanking(rankingPlayer, winProb, playerWinner)
    return rankingPlayer + (K * (playerWinner - winProb))
  end
end