module RoundsHelper
  def collectPlayersForAllTournmanets
    Player.all.order("firstName ASC, lastName ASC").collect {|p| [ p.completeName, p.id ] }
  end
end
