# frozen_string_literal: true

# Singleton for fetching user info for a provided token
class UserInfoFetcher
  def self.fetch(token)
    user_info_raw = send_request(token)
    JSON.parse(user_info_raw)
  rescue StandardError => e
    puts e
    nil
  end

  def self.send_request(token)
    uri = URI.parse("#{Rails.application.credentials.auth0[:domain]}userinfo")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.get(uri.request_uri, authorization: "Bearer #{token}").body
  end
end
