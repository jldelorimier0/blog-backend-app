class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      begin
        decoded_token = JWT.decode(
          token,
          "random",
          true,
          { algorithm: 'HS256' }
        )
        User.find_by(id: decoded_token[0]["user"])
      rescue JWT::ExpiredSignature
        nil
      end
    end
    # To get authentication out of the way, comment out everything inside this method above and uncomment the line below to hard code the first user as current_user:
    # current_user = User.first
  end

  helper_method :current_user

  def authenticate_user
    unless current_user
      render json: {}, status: :unauthorized
    end
  end
end
