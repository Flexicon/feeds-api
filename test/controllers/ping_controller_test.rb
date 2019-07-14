# frozen_string_literal: true

require 'test_helper'

class PingControllerTest < ActionDispatch::IntegrationTest
  test 'should get ping' do
    get ping_url
    assert_response :success
  end

  test 'should return health status' do
    get ping_url
    assert_response :ok
    assert_equal 'ok', json_response['health']
  end
end
