# -*- encoding : utf-8 -*-

class YoutubeCategoriesController < ApplicationController
  def index
    if params[:category]
      @accounts = YoutubeAccount.where(category: params[:category]).order('youtube_channel_subscriber_count DESC').includes(:influencer)
      if params[:sort_by]
        @accounts = YoutubeAccount.where(category: params[:category]).order("#{params[:sort_by]} DESC").includes(:influencer)
      end
    end
    @categories = YoutubeAccount.where.not(category: nil).group(:category).count.sort_by{|h| h[1]}.reverse
  end
end
