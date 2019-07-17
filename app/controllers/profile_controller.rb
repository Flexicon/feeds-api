# frozen_string_literal: true

# Returns user info for the currently authenticated user
class ProfileController < ApplicationController
  before_action :authenticate_user

  def me
    render json: current_user
  end
end
