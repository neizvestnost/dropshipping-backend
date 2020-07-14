# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :email, String, null: false
    field :phone_number, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
  end
end
