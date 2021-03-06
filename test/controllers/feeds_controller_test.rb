# frozen_string_literal: true

require 'test_helper'

class FeedsControllerTest < ActionDispatch::IntegrationTest
  include Minitest::Hooks

  def before_all
    @auth_header = make_test_user_auth_header
  end

  setup do
    @feed = feeds(:one)
  end

  test 'endpoint should require auth' do
    get feeds_url, as: :json
    assert_response :unauthorized
  end

  test 'should get list of feeds for user' do
    get feeds_url, as: :json, headers: @auth_header
    assert_response :success
  end

  test 'should create feed' do
    assert_difference('Feed.count') do
      post feeds_url, params: { feed: { name: @feed.name, url: @feed.url } }, as: :json, headers: @auth_header
    end

    assert_response 201
  end

  test 'should show feed' do
    get feed_url(@feed), as: :json, headers: @auth_header
    assert_response :success
  end

  test 'should update feed' do
    patch feed_url(@feed), params: { feed: { name: @feed.name, url: @feed.url } }, as: :json, headers: @auth_header
    assert_response 200
  end

  test 'should destroy feed' do
    assert_difference('Feed.count', -1) do
      delete feed_url(@feed), as: :json, headers: @auth_header
    end

    assert_response 204
  end
end
