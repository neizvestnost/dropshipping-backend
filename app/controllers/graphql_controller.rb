# frozen_string_literal: true

class GraphqlController < ApplicationController
  def execute
    result = DropshippingSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: {
        current_user: current_user,
      },
      operation_name: params[:operationName]
    )

    render json: result
  rescue => error
    raise error unless Rails.env.development?
    handle_error_in_development error
  end

  private

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? ensure_hash(JSON.parse(ambiguous_param)) : {}
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    render json: {
      errors: [
        {
          message: error.message,
          backtrace: error.backtrace,
        },
      ],
      data: {},
    }, status: 500
  end
end
