# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::Auth::SignUpMutation
    field :sign_in, mutation: Mutations::Auth::SignInMutation
  end
end
