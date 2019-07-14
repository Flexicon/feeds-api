# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Knock::Authenticable

  private

  def unauthorized_entity(_entity_name)
    render json: { error: 'Unauthorized request' }, status: :unauthorized
  end
end
