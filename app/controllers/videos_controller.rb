# -*- encoding : utf-8 -*-

class VideosController < ApplicationController
  def index
    @influencer = Influencer.friendly.find(params[:influencer_id])
    @videos = @influencer.account.videos.order("published_at DESC").paginate(:page => params[:page])
  end

  def show
    @video = Video.find(params[:id])
  end
end
