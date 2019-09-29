# frozen_string_literal: true

# Singleton for fetching RSS feed items and parsing them to entities
class RssFeedFetcher
  def self.fetch_items(feed)
    rss = URI.parse(feed.url).read
    parse_feed_for_items(rss, feed.id)
  rescue StandardError => e
    puts e
    nil
  end

  # TODO: validate if items exist in db already. Also save JSON/XML payload of item for backwards compatibility
  def self.parse_feed_for_items(rss, feed_id)
    doc = Nokogiri::XML(rss).root
    doc.xpath('channel/item').map do |item|
      FeedItem.new(
        feed_id: feed_id,
        title: item.at_xpath('title')&.text,
        description: item.at_xpath('description')&.text,
        guid: item.at_xpath('guid')&.text,
        pub_date: item.at_xpath('pubDate')&.text,
        link: item.at_xpath('link')&.text
      )
    end
  end
end
