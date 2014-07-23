module TourneysHelper
  
  def collectTournamentStates
    i = -1;
    Tourney.states.collect {|p| [ p, i += 1 ] }
  end
end
