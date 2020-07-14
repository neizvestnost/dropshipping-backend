# frozen_string_literal: true

module Extensions
  module Authenticable
    def user_sign_in?
      current_user.present?
    end

    def authenticate_user
      raise GraphQL::ExecutionError, I18n.t('auth.errors.authenticate') unless user_sign_in?
    end

    def current_user
      context[:current_user]
    end
  end
end
