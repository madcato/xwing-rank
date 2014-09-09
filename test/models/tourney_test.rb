require 'test_helper'

class TourneyTest < ActiveSupport::TestCase
  test "tourney title" do
    tourney = Tourney.new
    assert_not tourney.save, "Tourney saved without a name"
  end
  
  test "tourney title length" do
    tourney = Tourney.new
    tourney.titulo = "hola"
    assert_not tourney.save, "Tourney saved with a title too short"
  end
  
  test "tourney remove rankings" do
    ranking = Ranking.new
    ranking.save
    
    assert_difference('Ranking.count', -1) do
      tourney = Tourney.new
      tourney.titulo = "hola234234"
      tourney.rankings << ranking
      tourney.save
      
      tourney.destroy
    end
  end
end
