module RoundsHelper
  def collectPlayersForAllTournmanets
    Player.all.collect {|p| [ p.name, p.id ] }
  end
end
