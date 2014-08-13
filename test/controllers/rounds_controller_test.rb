require 'test_helper'

class RoundsControllerTest < ActionController::TestCase
  setup do
    @round = rounds(:roundOneTourneyOne)
    @tourney = tourneys(:tourneyOne)
    @user = users(:daniel)
    sign_in @user
  end

  test "should get index" do
    get :index, tourney_id: @tourney
    assert_response :success
    assert_not_nil assigns(:rounds)
  end

  test "should get new" do
    get :new, tourney_id: @tourney
    assert_response :success
  end

  test "should create round" do
    assert_difference('Round.count') do
      post :create, round: { order: @round.order, tourney_id: @round.tourney_id }, tourney_id: @tourney
    end

    assert_redirected_to tourney_round_path(@tourney,assigns(:round))
  end

  test "should show round" do
    get :show, id: @round, tourney_id: @tourney
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @round, tourney_id: @tourney
    assert_response :success
  end

  test "should update round" do
    patch :update, id: @round, round: { order: @round.order, tourney_id: @round.tourney_id }, tourney_id: @tourney
    assert_redirected_to tourney_round_path(@tourney,assigns(:round))
  end

  test "should destroy round" do
    assert_difference('Round.count', -1) do
      delete :destroy, id: @round, tourney_id: @tourney
    end

    assert_redirected_to tourney_rounds_path(@tourney)
  end
end
