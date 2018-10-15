# -*- encoding : utf-8 -*-

module InfluencerRatios
  extend ActiveSupport::Concern

  def youtube_engagement_ratio
    videos = self.account.videos
    return 0 if videos.length == 0 || self.account.youtube_channel_subscriber_count == 0
    (self.account.likes + self.account.dislikes) / self.account.youtube_channel_subscriber_count
  end

  def youtube_interaction_like_ratio
    videos = self.account.videos
    return 0 if videos.length == 0
    interaction_variable("like_count", videos)
  end

  def youtube_interaction_dislike_ratio
    videos = self.account.videos
    return 0 if videos.length == 0
    interaction_variable("dislike_count", videos)
  end

  def instagram_engagement_ratio
    self.account.likes
  end

  def instagram_interaction_ratio
    self.account.comments
  end

  private

  def interaction_variable(target, videos)
    result = 0
    videos.each do |v|
      case target
      when "like_count"
        !v.like_count.nil? ? result += v.like_count : result += 0
      when "dislike_count"
        !v.dislike_count.nil? ? result += v.dislike_count : result +=  0
      else
        result += 0
      end
    end
    ((result.to_f / self.account.total_one_click_interactions)*100).round(4)
  end
end
