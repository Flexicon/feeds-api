# frozen_string_literal: true

# Worker to enqueue users to have their feeds fetched
class QueueUserFeeds
  include Sidekiq::Worker

  def perform
    User.pluck(:id).each_with_index do |id, i|
      FetchFeedWorker.perform_in((i + 1).seconds, id)
    end
  end
end
