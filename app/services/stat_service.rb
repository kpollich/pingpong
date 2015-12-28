class StatService

  def initialize(match)
    @match = match
    @winner = @match.winner
    @loser = @match.loser
  end

  def update_stats
    @winner.wins += 1
    @loser.losses += 1
    save_players
  end

  def update_stats_for_deleted_match
    @winner.wins -= 1
    @loser.losses -= 1
    save_players
  end

  def update_stats_for_match_with_new_winner

    # The winner and loser have switched
    @winner, @loser = @loser, @winner

    @winner.wins -= 1
    @winner.losses += 1

    @loser.wins += 1
    @loser.losses -= 1

    save_players
  end

  private

  def save_players
    @winner.save
    @loser.save
  end
end
