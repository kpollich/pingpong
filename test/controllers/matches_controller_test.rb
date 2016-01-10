require 'test_helper'

class MatchesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matches)
  end

  test "should get new match" do
    get :new
    assert_response :success
    assert_not_nil assigns(:match)
  end

  test "should create match" do
    assert_difference("Match.count") do
      games = [
        { player1_id: "1", player2_id: "2", player1_score: "11", player2_score: "0" },
        { player1_id: "1", player2_id: "2", player1_score: "11", player2_score: "0" }
      ]
      post :create, match: { player1_id: "1", player2_id: "2", games_attributes: games }
    end
    assert_redirected_to matches_path
  end

  test "should update match" do
    games = [
      {
        "0": {player1_id: "1", player2_id: "2", player1_score: "0", player2_score: "11" },
        "1": {player1_id: "1", player2_id: "2", player1_score: "0", player2_score: "11" }
      }
    ]
    put :update, id: "1", match: { player1_id: "1", player2_id: "2", games_attributes: games }
    assert_redirected_to matches_path
  end
end
