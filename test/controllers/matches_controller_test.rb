require 'test_helper'


class MatchesControllerTest < ActionController::TestCase
  setup do
    @match = matches(:matchJoviDanielRoundOne)
    @round = rounds(:roundOneTourneyOne)
    @tourney = tourneys(:tourneyOne)
    @user = users(:daniel)
    sign_in @user
  end

  test "should get index" do
    get :index, tourney_id: @tourney, round_id: @round
    assert_response :success
    assert_not_nil assigns(:matches)
  end

  test "should get new" do
    get :new, tourney_id: @tourney, round_id: @round
    assert_response :success
  end

  test "should create match" do
    assert_difference('Match.count') do
      post :create, match: { player1_id: @match.player1_id, player2_id: @match.player2_id, round_id: @match.round_id, points1: @match.points1, points2: @match.points2 }, tourney_id: @tourney, round_id: @round
    end

    assert_redirected_to tourney_round_matches_path(@tourney,@round)
  end

  test "should get edit" do
    get :edit, id: @match, tourney_id: @tourney, round_id: @round
    assert_response :success
  end

  test "should update match" do
    patch :update, id: @match, match: { player1_id: @match.player1_id, player2_id: @match.player2_id, round_id: @match.round_id, points1: @match.points1, points2: @match.points2 }, tourney_id: @tourney, round_id: @round
    assert_redirected_to tourney_round_matches_path(@tourney,@round)
  end

  test "should destroy match" do
    assert_difference('Match.count', -1) do
      delete :destroy, id: @match, tourney_id: @tourney, round_id: @round
    end

    assert_redirected_to tourney_round_matches_path(@tourney,@round)
  end
end
