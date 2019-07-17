# frozen_string_literal: true

require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test 'should require auth me' do
    get me_url
    assert_response :unauthorized
  end
end
