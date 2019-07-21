# frozen_string_literal: true

# Main application controller
class ApplicationController < ActionController::API
  include Knock::Authenticable

  private

  # Stub for current_user magic method
  def current_user; end

  # Override of vendor Knock method in order to inject a CustomAuthToken
  # As well as to throw an error for debugging
  # Usually this error is suppressed by the rescue_from line above
  # rubocop:disable Metrics/MethodLength
  def define_current_entity_getter(entity_class, getter_name)
    return nil if respond_to? getter_name

    memoization_var_name = "@_#{getter_name}"
    self.class.send(:define_method, getter_name) do
      unless instance_variable_defined?(memoization_var_name)
        current =
          begin
            CustomAuthToken.new(token: token).entity_for(entity_class)
          rescue StandardError => e
            puts e.message
            throw e if Rails.env.development? # Throw this error when debugging
          end
        instance_variable_set(memoization_var_name, current)
      end
      instance_variable_get(memoization_var_name)
    end
  end
  # rubocop:enable Metrics/MethodLength

  def unauthorized_entity(_entity_name)
    render json: { error: 'Unauthorized request' }, status: :unauthorized
  end

  def authenticate_user
    super
  end
end
