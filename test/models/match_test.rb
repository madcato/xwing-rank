require 'test_helper'

class MatchTest < ActiveSupport::TestCase

  test "Bad points value" do
    match = Match.new
    match.player1 = players(:jovi)
    match.round = rounds(:roundOneTourneyOne)
    match.points1 = -50
    assert_not match.save, "Saved the match with negative points"
  end
  
  test "Same player match" do
    match = Match.new
    match.player1 = players(:jovi)
    match.player2 = players(:jovi)
    match.round = rounds(:roundOneTourneyOne)
    match.points1 = 50
    match.points2 = 50
    assert_not match.save, "Saved a match with not different players"
  end
  
  test "At least one player" do
    match = Match.new
    match.round = rounds(:roundOneTourneyOne)
    match.points1 = 50
    match.points2 = 50
    assert_not match.save, "Saved a match without players."
  end
  
  test "Add rankings" do
    rankingInicialJovi = rankings(:rankingJoviOne)
    rankingInicialDaniel = rankings(:rankingDanielOne)
    match = Match.new
    match.player1 = players(:jovi)
    match.player2 = players(:daniel)
    match.round = rounds(:roundOneTourneyOne)
    match.points1 = 100
    match.points2 = 50
    match.save
    
    rankingJovi = match.round.tourney.rankings.find_by(player_id: match.player1)
    rankingDaniel = match.round.tourney.rankings.find_by(player_id: match.player2)
    
    assert_equal(rankingInicialJovi.points + 5, rankingJovi.points, "Not added points to player1(winner)")
    assert_equal(rankingInicialDaniel.points, rankingDaniel.points, "Added points to player2(looser)")
    
    assert_equal(rankingInicialJovi.breakpoints + 150, rankingJovi.breakpoints, "Bad added breakpoints to player1(winner)")
    assert_equal(rankingInicialDaniel.breakpoints + 50, rankingDaniel.breakpoints, "Bad added breakpoints to player2(looser)")
    
  end  
  
  test "match tie" do
    rankingInicialJovi = rankings(:rankingJoviOne)
    rankingInicialDaniel = rankings(:rankingDanielOne)
    match = Match.new
    match.player1 = players(:jovi)
    match.player2 = players(:daniel)
    match.round = rounds(:roundOneTourneyOne)
    match.points1 = 45
    match.points2 = 45
    match.save
    
    rankingJovi = match.round.tourney.rankings.find_by(player_id: match.player1)
    rankingDaniel = match.round.tourney.rankings.find_by(player_id: match.player2)
    
    assert_equal(rankingInicialJovi.points + 1, rankingJovi.points, "Not added points to player1(winner)")
    assert_equal(rankingInicialDaniel.points + 1, rankingDaniel.points, "Added points to player2(looser)")
    
    assert_equal(rankingInicialJovi.breakpoints + 100, rankingJovi.breakpoints, "Bad added breakpoints to player1(winner)")
    assert_equal(rankingInicialDaniel.breakpoints + 100, rankingDaniel.breakpoints, "Bad added breakpoints to player2(looser)")
    
  end  
  
  test "match lose" do
    rankingInicialJovi = rankings(:rankingJoviOne)
    rankingInicialDaniel = rankings(:rankingDanielOne)
    match = Match.new
    match.player1 = players(:jovi)
    match.player2 = players(:daniel)
    match.round = rounds(:roundOneTourneyOne)
    match.points1 = 45
    match.points2 = 85
    match.save
    
    rankingJovi = match.round.tourney.rankings.find_by(player_id: match.player1)
    rankingDaniel = match.round.tourney.rankings.find_by(player_id: match.player2)
    
    assert_equal(rankingInicialJovi.points, rankingJovi.points, "Not added points to player1(looser)")
    assert_equal(rankingInicialDaniel.points + 5, rankingDaniel.points, "Added points to player2(winner)")
    
    assert_equal(rankingInicialJovi.breakpoints + 60, rankingJovi.breakpoints, "Bad added breakpoints to player1(looser)")
    assert_equal(rankingInicialDaniel.breakpoints + 140, rankingDaniel.breakpoints, "Bad added breakpoints to player2(winner)")
    
  end  
  
  test "match modified win" do
    rankingInicialJovi = rankings(:rankingJoviOne)
    rankingInicialDaniel = rankings(:rankingDanielOne)
    match = Match.new
    match.player1 = players(:jovi)
    match.player2 = players(:daniel)
    match.round = rounds(:roundOneTourneyOne)
    match.points1 = 40
    match.points2 = 45
    match.save
    
    rankingJovi = match.round.tourney.rankings.find_by(player_id: match.player1)
    rankingDaniel = match.round.tourney.rankings.find_by(player_id: match.player2)
    
    assert_equal(rankingInicialJovi.points, rankingJovi.points, "Not added points to player1(looser)")
    assert_equal(rankingInicialDaniel.points + 3, rankingDaniel.points, "Added points to player2(winner)")
    
    assert_equal(rankingInicialJovi.breakpoints + 95, rankingJovi.breakpoints, "Bad added breakpoints to player1(looser)")
    assert_equal(rankingInicialDaniel.breakpoints + 105, rankingDaniel.breakpoints, "Bad added breakpoints to player2(winner)")
    
  end  
  
  test "remove rankings" do
    rankingInicialJovi = rankings(:rankingJoviOne)
    rankingInicialDaniel = rankings(:rankingDanielOne)
    match = Match.new
    match.player1 = players(:jovi)
    match.player2 = players(:daniel)
    match.round = rounds(:roundOneTourneyOne)
    match.points1 = 40
    match.points2 = 45
    match.save
    
    match.destroy
    
    rankingJovi = match.round.tourney.rankings.find_by(player_id: match.player1)
    rankingDaniel = match.round.tourney.rankings.find_by(player_id: match.player2)
    
    assert_equal(rankingInicialJovi.points, rankingJovi.points, "Removing ranking points fail.")
    assert_equal(rankingInicialDaniel.points, rankingDaniel.points, "Removing ranking points fail.")
    
    assert_equal(rankingInicialJovi.breakpoints, rankingJovi.breakpoints, "Removing ranking breakpoints fail.")
    assert_equal(rankingInicialDaniel.breakpoints, rankingDaniel.breakpoints, "Removing ranking breakpoints fail.")
    
  end
end
