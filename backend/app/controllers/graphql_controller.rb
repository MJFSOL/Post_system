# app/controllers/graphql_controller.rb
class GraphqlController < ApplicationController
  # protect_from_forgery with: :null_session
  # skip_before_action :verify_authenticity_token

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user_from_jwt
    }

    result = BackendSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  def prepare_variables(variables_param)
    case variables_param
    when String
      variables_param.present? ? JSON.parse(variables_param) : {}
    when Hash, ActionController::Parameters
      variables_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")
    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  def current_user_from_jwt
    auth_header = request.headers['Authorization']
    return nil unless auth_header.present?

    token = auth_header.split(' ').last
    return nil if token.blank?

    Warden::JWTAuth::UserDecoder.new.call(token, :user, nil)
  rescue StandardError
    nil
  end
end
