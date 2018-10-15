# -*- encoding : utf-8 -*-
module Score
  extend ActiveSupport::Concern
  include YoutubeScores
  include InstagramScores

  def limits
    limits = YAML.load_file('config/score_limits.yml')
  end

  def get_score
    if self.platform == "YouTube"
      return ((subscribers_score + views_score + engagement_score) / 3).round(1)
    elsif self.platform == "Instagram"
      return (follower_score).round(1)
    end
    0.0
  end
end
