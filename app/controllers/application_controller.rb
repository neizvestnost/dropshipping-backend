class ApplicationController < ActionController::API
  private

  def authenticate_user
    @decoded = Auth::JwtWebToken.decode(request.headers['Auth'])
  rescue JWT::DecodeError, JWT::VerificationError
    render json: { errors: 'Incorrect token' }, status: :unauthorized
  end

  def current_user
    @current_user ||= User.find_by(id: @decoded[:user_id])
  end
end
