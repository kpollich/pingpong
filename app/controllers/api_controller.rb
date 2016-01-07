class ApiController < ActionController::Base
  before_action :authenticate

  def respond_json (data)
    respond_to do |format|
      format.json { render json: data }
    end
  end

  protected

  def authenticate
    if user = authenticate_with_http_basic { |u, p| Player.find_by(name: u).authenticate(p) }
      @current_user = user
    else
      render :nothing => true, :status => :unauthorized
    end
  end
end
