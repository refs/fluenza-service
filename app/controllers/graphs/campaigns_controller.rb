class Graphs::CampaignsController < Graphs::ApplicationController
  include DataSetFormatter

  def youtube_views
    campaign = Campaign.find(params[:id])
    payload = campaign_data_set(campaign.views_fluctuation)
    payload[:influencers] = campaign.videos.includes(:youtube_account).map do |v|
      v.youtube_account.influencer.title
    end
    render json: { views: payload }, head: :ok
  end

  def posts_likes
    campaign = Campaign.find(params[:id])
    payload = campaign_data_set(campaign.instagram_likes)
    payload[:influencers] = campaign.posts.includes(:instagram_account).map do |v|
      v.instagram_account.influencer.title
    end
    render json: { views: payload }, head: :ok
  end
end
