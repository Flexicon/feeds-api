# frozen_string_literal: true

require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test 'GET /me should require auth' do
    get me_url
    assert_response :unauthorized
  end

  test 'GET /me should return user when authenticated' do
    user = users(:one)
    get me_url, headers: make_test_user_auth_header
    assert_response :success
    assert_equal JSON.parse(user.to_json), json_response
  end
end
