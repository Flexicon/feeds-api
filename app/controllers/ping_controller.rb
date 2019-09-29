# frozen_string_literal: true

# Responsible for general API health/sanity checking
class PingController < ApplicationController
  def health_check
    render json: { health: 'ok' }, status: :ok
  end
end
