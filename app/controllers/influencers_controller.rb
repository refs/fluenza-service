# -*- encoding : utf-8 -*-

class InfluencersController < ApplicationController
  include Follows

  def index
    if params[:title].present?
      @influencers = Influencer.where("title LIKE ?", "%#{params[:title]}%").includes(:account).order("score DESC")
    else
      @influencers = Influencer.all.includes(:account).order("score DESC")
    end
    if params[:platform].present?
      @influencers = Influencer.where(platform: params[:platform]).includes(:account).order("score DESC")
    end
  end

  def show
    @influencer = Influencer.friendly.find(params[:id])
    if @influencer.platform == 'YouTube'
      if !@influencer.account.nil?
        @youtube_account = @influencer.account
        @youtube_interaction_like_ratio = @influencer.youtube_interaction_like_ratio
        @youtube_interaction_dislike_ratio = @influencer.youtube_interaction_dislike_ratio
        @youtube_engagement_ratio = @influencer.youtube_engagement_ratio
        @subscribers_score = @influencer.subscribers_score.round(1)
        @views_score = @influencer.views_score.round(1)
        @engagement_score = @influencer.engagement_score.round(1)
        @influencer_score = ((@subscribers_score + @views_score + @engagement_score) / 3).round(1)
        @sponsored_content_ratio = @influencer.account.sponsored_content_ratio
        @sponsored_content_views = @influencer.account.sponsored_content_views
      end
    elsif @influencer.platform == "Instagram"
      @platform = @influencer.platform
      @posts = @influencer.account.posts.order('published_at DESC')
      @top_hashtags = top_10_hashtags(@influencer)
    end
  end

  def refresh_snapshots
    influencer = Influencer.friendly.find(params[:id])
    influencer.create_or_update_snapshot
    redirect_to influencer_path(influencer)
  end

  private
  def influencer_params
    params.permit(:influencer_id, :profile_id)
  end

  def top_10_hashtags(influencer)
    bundle = ""
    matcher= /(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i
    influencer.account.posts.each do |post|
      if !post.description.nil?
        bundle +=  post.description
      end
    end
    hashtags_array = bundle.scan(matcher)
    hashtags_array.group_by{|i| i}.map{|k,v| [v.count, k] }.sort.reverse.first(10)
  end
end
