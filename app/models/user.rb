# frozen_string_literal: true

# Authorized user model, persisted on any auth request if not already in the system
class User < ApplicationRecord
  has_many :feeds

  def self.from_token_payload(payload, token)
    begin
      user = find payload['sub']
    rescue StandardError
      user_info = UserInfoFetcher.fetch token
      return nil if user_info.nil?

      user = from_user_info_payload user_info
      user.save!
    end
    user
  end

  def self.from_user_info_payload(payload)
    user = User.new
    user.id = payload['sub']
    user.name = payload['name']
    user.email = payload['email']
    user.picture = payload['picture']
    user
  end
end
