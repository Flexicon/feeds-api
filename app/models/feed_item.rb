# frozen_string_literal: true

# RSS Feed item model
class FeedItem < ApplicationRecord
  belongs_to :feed
end
