# frozen_string_literal: true

module Mutations
  module Auth
    class SignInMutation < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :token, String, null: true
      field :user, Types::UserType, null: true

      def resolve(**args)
        @user = User.find_by(email: args[:email])
        raise GraphQL::ExecutionError, I18n.t('auth.sign_in.errors.user_not_found') if @user.blank?

        unless @user.authenticate(args[:password])
          raise GraphQL::ExecutionError, I18n.t('auth.sign_in.errors.user_not_found')
        end

        token = ::Auth::JwtWebToken.encode({ user_id: @user.id })
        { token: token, user: @user }
      end
    end
  end
end
