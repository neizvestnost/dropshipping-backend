# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def authenticate_request
    @decoded = Auth::JwtWebToken.decode(request.headers['Auth'])
  rescue JWT::DecodeError, JWT::VerificationError
    nil
  end

  def current_user
    @current_user ||= User.find_by(id: authenticate_request&.fetch(:user_id, nil))
  end
end
