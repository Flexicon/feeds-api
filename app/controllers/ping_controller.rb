# frozen_string_literal: true

# Responsible for a general API health check
class PingController < ApplicationController
  def health_check
    render json: { health: 'ok' }.to_json, status: :ok
  end
end
