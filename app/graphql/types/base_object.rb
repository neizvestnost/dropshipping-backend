# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    include Extensions::Authenticable

    field_class Types::BaseField
  end
end
