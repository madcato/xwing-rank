module MatchesHelper
  
  # TODO this method must be edited to return only the players of the tournament
  def collectPlayersForTournmanet(tourny)
    Player.all.collect {|p| [ p.name, p.id ] }
  end
end
