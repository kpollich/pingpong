module Api
  class ApiController < JSONAPI::ResourceController
    before_action :authenticate
    protect_from_forgery with: :null_session

    protected

    def authenticate
      if user = authenticate_with_http_basic { |u, p| Player.find_by(name: u).authenticate(p) }
        @current_user = user
      else
        render :nothing => true, :status => :unauthorized
      end
    end

  end
end
