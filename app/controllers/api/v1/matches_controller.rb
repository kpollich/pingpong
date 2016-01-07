class Api::V1::MatchesController < ApiController
  def index
    @matches = Match.all
    respond_json @matches
  end

  def show
    @match = Match.find params[:id]
    respond_json @match
  end
end
