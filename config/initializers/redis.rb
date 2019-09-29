# frozen_string_literal: true

REDIS = Redis.new(uri: URI.parse(ENV['REDISTOGO_URL']))
