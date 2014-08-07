require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  test "order must exists" do
    tourney = tourneys(:tourneyOne)
    round = tourney.rounds.new
    assert round.save, "Round must be saved"
  end
  
  test "next round not first" do
    tourney = tourneys(:tourneyOne)
    round = tourney.rounds.new
    round.save
    assert_not round.order == 1, "Must create a new round without order 1"
  end
  
  test "first round set to order 1" do
    tourney = tourneys(:tourneyTwo)
    round = tourney.rounds.new
    round.save
    assert round.order == 1, "Must create first round with order 1"
  end
  
  test "previoud round" do
    round1 = rounds(:roundOneTourneyOne)
    round2 = rounds(:roundTwoTourneyOne)
    previousRound = round2.previousRound
    assert_equal round1, previousRound, "Previous round of second round must be first one"
  end
  
  test "all matches filled" do
    round = rounds(:roundOneTourneyOne)
    assert round.allMatchesFilled?, "All matches must be filled"
  end
  
  test "not all matches filled" do
    round = rounds(:roundTwoTourneyOne)
    assert_not round.allMatchesFilled?, "All matches are not filled"
  end
  
  test "seed not first round" do
    tourney = tourneys(:tourneyOne)
    round = tourney.rounds.new
    assert round.matches.count == 0, "New round must not have any match"
    round.seedRound
    assert round.matches.count > 0, "Matches must be created"
  end
  
  test "seed first round" do
    tourney = tourneys(:tourneyTwo)
    round = tourney.rounds.new
    round.save
    assert round.isFirstRound?, "First round must be created"
    assert round.matches.count == 0, "New round must not have any match"
    round.seedRound
    assert round.matches.count > 0, "Matches must be created"
  end
  
end
