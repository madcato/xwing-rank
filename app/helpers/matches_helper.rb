module MatchesHelper
  
  def collectPlayersForTournmanet(tourney)
    tourney.players.order("firstName ASC, lastName ASC").collect {|p| [ p.completeName, p.id ] }
  end
  
  def collectResults
    Match.possibleResults
  end
end
