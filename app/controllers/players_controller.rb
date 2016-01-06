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

  def login
    player = Player.find_by(name: player_params[:name])
    if player && player.authenticate(player_params[:password])
      session[:player_id] = player.id
      redirect_to '/'
    else
      flash[:error] = "Invalid credentials, try again."
      @player = Player.new(name: player_params[:name])
      redirect_to '/'
    end
  end

  def logout
    session.destroy
    flash[:success] = "Successfully logged out!"
    redirect_to "/"
  end

  private

  def player_params
    params.require(:player).permit(:name, :password, :password_confirmation)
  end
end
