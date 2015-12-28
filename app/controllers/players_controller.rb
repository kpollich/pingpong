class PlayersController < ApplicationController
  def index
    @players = Player.all.order(wins: :desc)
  end

  def show
    @player = Player.find(params[:id])
    @history = PlayerHistory.from_player(@player)
  end

  def new
    @player = Player.new
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      flash[:success] = "Player '#{@player.name}' created!"
      redirect_to players_path
    else
      render 'new'
    end
  end

  def update
    player = Player.find(params[:id])
    player.update(player_params)
    redirect_to player
  end

  def destroy
    player = Player.find(params[:id])
    history = PlayerHistory.from_player(player)

    # Delete each match/game in this player's history
    history.each do |match|
      StatService.new(match).update_stats_for_deleted_match
      match.destroy
    end
    player.destroy

    flash[:success] = "Player '#{player.name}' deleted!"
    redirect_to players_path
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
