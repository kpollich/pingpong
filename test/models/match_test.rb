require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  def setup
    games = []
    2.times do
      games.push(Game.new(player1_id: 1, player2_id: 2, player1_score: 11, player2_score: 0))
    end
    @match = Match.new(player1_id: 1, player2_id: 2, games: games)
  end

  def teardown
    @match = nil
  end

  test "should have player one" do
    assert_equal(@match.player1.id, 1)
  end

  test "should have player two" do
    assert_equal(@match.player2.id, 2)
  end

  test "should have no winner at 1-1" do
    @match.games.first.player1_score = 0
    @match.games.first.player2_score = 11

    # Match is tied 1-1, there is no winner
    assert_not(@match.save, "Should not save")
    assert_equal(@match.errors[:base], ["Match does not have a winner. A player must win 2 out of 3 games."],
      "Should provide error message for lack of winner")
  end

  test "should not save with one game" do
    @match.games.delete(@match.games.first)

    # Match only has one game played, should throw an error
    assert_not(@match.save, "Should not save")
    assert_equal(@match.errors[:base], ["Matches must contain two or three games."],
      "Should provide error message - not enough games played.")
  end

  test "should not save with more than two wins" do
    @match.games.push(Game.new(player1_id: 1, player2_id: 2, player1_score: 11, player2_score: 0))

    # Match has 3 games in which player1 is the winner - this is an invalid win condition
    assert_not(@match.save, "Should not save")
    assert_equal(@match.errors["base"], ["A player cannot have more than two wins."],
      "Should provide error message - too many wins.")
  end

  test "should have winner and loser at 2-0" do

    # Player One wins 2-0 in our setup method
    assert(@match.save, "Should save")
    assert_equal(@match.winner.id, 1, "Match's winner should be player one")
    assert_equal(@match.loser.id, 2, "Match's loser should be player two")
  end

  test "should have winner and loser at 2-1" do
    @match.games.first.assign_attributes(player1_score: 0, player2_score: 11)
    @match.games.push(Game.new(player1_id: 1, player2_id: 2, player1_score: 0, player2_score: 11))

    assert(@match.save, "Should save")
    assert_equal(@match.winner.id, 2, "Match's winner should be player two")
    assert_equal(@match.loser.id, 1, "Match's loser should be player one")
  end

  test "should correct stats when winner changes" do
    @match.save

    @match.games.first.assign_attributes(player1_score: 0, player2_score: 11)
    @match.games.push(Game.new(player1_id: 1, player2_id: 2, player1_score: 0, player2_score: 11))

    object = mock()
    object.expects(:update_stats_for_match_with_new_winner)
    StatService.stubs(:new).with(@match).returns(object)

    @match.save
  end
end
