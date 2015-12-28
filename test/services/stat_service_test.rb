require 'test_helper'

class StatServiceTest < ActionController::TestCase
  def setup
    @match = Match.first
    @wins = @match.winner.wins
    @losses = @match.loser.losses

    @stat_service = StatService.new(@match)

  end

  def teardown
    @stat_service = nil
  end

  test "should increase wins and losses by one" do
    @stat_service.update_stats
    assert_equal(@match.winner.wins, @wins + 1, "Winner should have one more win")
    assert_equal(@match.loser.losses, @losses + 1, "Loser should have one more loss")
  end

  test "should decrease wins and losses by one" do
    @stat_service.update_stats_for_deleted_match
    assert_equal(@match.winner.wins, @wins - 1, "Winner should have one less win")
    assert_equal(@match.loser.losses, @losses - 1, "Loser should have one less loss")
  end

  test "should update stats for new winner" do
    winner_losses = @match.winner.losses
    loser_wins = @match.loser.wins

    # The new loser is the previous winner, and vice versa
    @stat_service.update_stats_for_match_with_new_winner
    assert_equal(@match.loser.wins, @wins - 1, "Previous Winner should have one less win")
    assert_equal(@match.loser.losses, winner_losses + 1, "Previous Winner should have one more loss")
    assert_equal(@match.winner.losses, @losses - 1, "Previous Loser should have one less loss")
    assert_equal(@match.winner.wins, loser_wins + 1, "Previous Loser should have one more win")
  end
end
