module MatchesHelper
  
  def collectPlayersForTournmanet(tourney)
    tourney.players.collect {|p| [ p.completeName, p.id ] }
  end
  
  def collectResults
    Match.possibleResults
  end
end
