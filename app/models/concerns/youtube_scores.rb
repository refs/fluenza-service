module YoutubeScores
  extend ActiveSupport::Concern

  def subscribers_score
    subscribers_score = Math.log(self.account.youtube_channel_subscriber_count.to_f / limits["subscribers"]) + 10
    subscribers_score < 0 ? 0 : subscribers_score
  end

  def views_score
    views_score = Math.log(self.account.youtube_channel_view_count.to_f / limits["views"]) + 10
    views_score < 0 ? 0 : views_score
  end

  def engagement_score
    engagement_score = Math.log(self.youtube_engagement_ratio.to_f / 100) + 10
    engagement_score < 0 ? 0 : engagement_score
  end
end
