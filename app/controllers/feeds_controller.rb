# frozen_string_literal: true

# Feeds CRUD
class FeedsController < ApplicationController
  before_action :authenticate_user
  before_action :set_feed, only: %i[show update destroy]

  # GET /feeds
  def index
    @feeds = Feed.where(user: current_user.id).all

    render json: serialize(@feeds)
  end

  # GET /feeds/1
  def show
    render json: serialize(@feed)
  end

  # POST /feeds
  def create
    @feed = Feed.new(feed_params.merge(user: current_user))

    if @feed.save
      render json: serialize(@feed), status: :created, location: @feed
    else
      render json: @feed.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /feeds/1
  def update
    if @feed.update(feed_params)
      render json: serialize(@feed)
    else
      render json: @feed.errors, status: :unprocessable_entity
    end
  end

  # DELETE /feeds/1
  def destroy
    @feed.destroy
  end

  protected

  def serialize(feeds)
    super(feeds, FeedSerializer)
  end

  private

  def set_feed
    @feed = Feed.where(user: current_user).find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def feed_params
    params.require(:feed).permit(:url, :name)
  end
end
