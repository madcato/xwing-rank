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
end
