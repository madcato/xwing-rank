module MatchesHelper
  
  def collectPlayersForTournmanet(tourney)
    tourney.players.all.collect {|p| [ p.name, p.id ] }
  end
  
  def collectResults
    Match.possibleResults
  end
end
