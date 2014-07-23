module MatchesHelper
  
  # TODO this method must be edited to return only the players of the tournament
  def collectPlayersForTournmanet(tourney)
    tourney.players.all.collect {|p| [ p.name, p.id ] }
  end
  
  def collectResults
    Match.results
  end
end
