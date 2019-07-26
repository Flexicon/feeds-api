# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'minitest/hooks/default'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml
  # for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def json_response
    ActiveSupport::JSON.decode @response.body
  end

  def make_test_user_auth_header
    token = self.class.fetch_test_token
    { 'Authorization': "Bearer #{token}" }
  end

  def self.fetch_test_token
    uri = URI.parse("#{Rails.application.credentials[:auth0][:domain]}oauth/token")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.post(
      uri.request_uri, URI.encode_www_form(prepare_auth_data), 'content-type': 'application/x-www-form-urlencoded'
    )
    parse_auth_response(response)['access_token']
  end

  def self.prepare_auth_data
    {
      grant_type: 'http://auth0.com/oauth/grant-type/password-realm',
      realm: 'Username-Password-Authentication',
      client_id: Rails.application.credentials[:auth0][:client_id],
      audience: Rails.application.credentials[:auth0][:api_audience],
      scope: 'openid profile email',
      username: tester_email,
      password: tester_pass
    }
  end

  def self.parse_auth_response(response)
    return nil if response.code.to_i != 200

    JSON.parse(response.body)
  end

  def self.tester_email
    Rails.application.credentials[:auth0][:test][:username]
  end

  def self.tester_pass
    Rails.application.credentials[:auth0][:test][:password]
  end
end
