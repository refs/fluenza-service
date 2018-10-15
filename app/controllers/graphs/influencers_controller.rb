# -*- encoding : utf-8 -*-

class Graphs::InfluencersController < Graphs::ApplicationController
  include DataSetFormatter
  before_action :set_influencer

  def youtube_subscribers
    data = @current_influencer.account.subscribers
    payload = item_data_set(data)
    render json: payload
  end

  def youtube_views
    data = @current_influencer.account.views
    payload = item_data_set(data)
    render json: payload
  end

  def instagram_followers
    data = @current_influencer.account.ig_subscribers
    payload = item_data_set(data)
    render json: payload
  end

  def instagram_likes
    data = @current_influencer.account.ig_likes
    payload = item_data_set(data)
    render json: payload
  end

  private

  def set_influencer
    @current_influencer = Influencer.friendly.find(params[:id])
  end
end
