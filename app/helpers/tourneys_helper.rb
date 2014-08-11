module TourneysHelper
  
  def collectTournamentStates
    i = -1;
    Tourney.states.collect {|p| [ p, i += 1 ] }
  end
  
  
  def checkActiveTab(tabName)
    if @activeTab == tabName
      return "active"
    end
    return ""
  end

  def checkRound(round)
    if @selectedRound == round
      return "active"
    end
    return ""
  end
  

end
