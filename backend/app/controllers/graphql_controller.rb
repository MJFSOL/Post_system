# app/controllers/graphql_controller.rb
class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user_from_jwt
    }

    result = YourAppSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  def current_user_from_jwt
    auth_header = request.headers['Authorization']
    return nil unless auth_header.present?
    token = auth_header.split(' ').last
    return nil if token.blank?
    Warden::JWTAuth::UserDecoder.new.call(token, :user, nil)
  rescue StandardError
    nil
  end

  # prepare_variables method as generator created (keep it)
end
