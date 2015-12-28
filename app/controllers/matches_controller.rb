class MatchesController < ApplicationController
  def index
    @matches = Match.all.order(created_at: :desc)
  end

  def new
    @match = Match.new
    if params[:player]
      @match.player1_id = params[:player]
    end
    build_games
  end

  def edit
    @match = Match.find(params[:id])
    build_games
  end

  def create
    @match = Match.new(match_params)
    normalize_games

    if @match.save
      StatService.new(@match).update_stats
      flash[:success] = "Match created!"
      redirect_to matches_path
    else
      build_games
      render 'new'
    end
  end

  def update
    @match = Match.find(params[:id])

    @match.assign_attributes(match_params)
    normalize_games

    if @match.save
      flash[:success] = "Successfully updated match!"
      redirect_to matches_path
    else
      render 'edit'
    end
  end

  def destroy
    @match = Match.find(params[:id])

    # Remove one win/one loss from each player in this match
    StatService.new(@match).update_stats_for_deleted_match

    if @match.destroy
      flash[:success] = "Successfully deleted match!"
      redirect_to matches_path
    else
      render 'index'
    end
  end

  private

  def match_params
    params
      .require(:match)
      .permit(
        :player1_id,
        :player2_id,
        games_attributes: [:id, :player1_score, :player2_score]
      )
  end

  # Initialize 3 new games for each match
  def build_games
    until @match.games.size == 3
      @match.games.build
    end
  end

  # If the game goes from 3 games to 2, get rid of the game with no scores
  def normalize_games
    @match.games.each do |game|
      if !game.player1_score.present? && !game.player2_score.present?
        @match.games.delete(game)
        next
      end
      game.player1_id = @match.player1_id
      game.player2_id = @match.player2_id
    end
  end
end
