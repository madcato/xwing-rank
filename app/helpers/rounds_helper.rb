module RoundsHelper
  def collectPlayersForAllTournmanets
    Player.all.collect {|p| [ p.completeName, p.id ] }
  end
end
