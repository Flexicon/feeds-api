# frozen_string_literal: true

require 'open-uri'

# Worker to asynchronously fetch feeds for a user and add notifications if needed
class FetchFeedWorker
  include Sidekiq::Worker

  def perform(user_id)
    puts("Need to fetch feeds for user: #{user_id}")

    feeds = Feed.where(user: user_id)

    if feeds.empty?
      puts('No feeds found for user.')
    else
      puts("Found #{feeds.size} feed(s).")
    end

    handle_feeds(feeds)
  end

  private

  def handle_feeds(feeds)
    # TODO: after feed items have been saved to DB, user should be notified
    feeds.each do |feed|
      items = RssFeedFetcher.fetch_items(feed)
      items.each do |item|
        puts("New item: #{item.title || item.description}")
      end

      FeedItem.transaction do
        items.each(&:save!)
      end
    end
  end
end
