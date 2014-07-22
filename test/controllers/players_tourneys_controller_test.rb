require 'test_helper'

class PlayersTourneysControllerTest < ActionController::TestCase
  setup do
    @players_tourney = players_tourneys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players_tourneys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create players_tourney" do
    assert_difference('PlayersTourney.count') do
      post :create, players_tourney: { player_id: @players_tourney.player_id, tourney_id: @players_tourney.tourney_id }
    end

    assert_redirected_to players_tourney_path(assigns(:players_tourney))
  end

  test "should show players_tourney" do
    get :show, id: @players_tourney
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @players_tourney
    assert_response :success
  end

  test "should update players_tourney" do
    patch :update, id: @players_tourney, players_tourney: { player_id: @players_tourney.player_id, tourney_id: @players_tourney.tourney_id }
    assert_redirected_to players_tourney_path(assigns(:players_tourney))
  end

  test "should destroy players_tourney" do
    assert_difference('PlayersTourney.count', -1) do
      delete :destroy, id: @players_tourney
    end

    assert_redirected_to players_tourneys_path
  end
end
