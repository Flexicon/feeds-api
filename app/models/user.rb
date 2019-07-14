# frozen_string_literal: true

# Authorized user model, persisted on any auth request if not already in the system
class User < ApplicationRecord
  def self.from_token_payload(payload)
    # { name: payload['name'], email: payload['email'], id: payload['sub'] }
    begin
      user = find payload['sub']
    rescue StandardError
      user = User.new
      user.id = payload['sub']
      user.name = payload['name']
      user.email = payload['email']
      user.save!
    end
    user
  end
end
