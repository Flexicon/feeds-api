# frozen_string_literal: true

# Handles Feed model serialization
class FeedSerializer < ActiveModel::Serializer
  attributes :id, :name, :url
end
