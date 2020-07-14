# frozen_string_literal: true

module Mutations
  module Auth
    class SignUpMutation < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :phone_number, String, required: true

      field :success, Boolean, null: false

      def resolve(**args)
        @user = User.new(args)
        { success: @user.save }
      rescue ActiveRecord::RecordNotUnique
        raise GraphQL::ExecutionError, I18n.t('auth.sign_up.errors.user_exists')
      end
    end
  end
end
