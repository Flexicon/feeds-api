# frozen_string_literal: true

class CreateFeedItems < ActiveRecord::Migration[6.0]
  def change
    create_table :feed_items do |t|
      t.string :title
      t.string :description
      t.string :link
      t.datetime :pub_date
      t.string :guid
      t.references :feed, index: true, foreign_key: true

      t.timestamps
    end
  end
end
