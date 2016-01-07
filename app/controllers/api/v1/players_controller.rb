class Api::V1::PlayersController < ApiController
  def index
    @players = Player.find_all
    respond_json @players
  end

  def show
    @player = Player.find params[:id]
    respond_json @player
  end
end
