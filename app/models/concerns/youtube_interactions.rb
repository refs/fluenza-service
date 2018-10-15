# -*- encoding : utf-8 -*-
module YoutubeInteractions
  extend ActiveSupport::Concern

  def videos_view_count
    return 1 if self.videos.count == 0 || self.likes == 0 || self.dislikes == 0
    self.videos.sum(:view_count)
  end

  def total_interactions
    return 1 if self.videos.count == 0 || self.likes == 0 || self.dislikes == 0
    self.likes + self.dislikes + self.comments
  end

  def total_one_click_interactions
    return 1 if self.videos.count == 0 || self.likes == 0 || self.dislikes == 0
    self.likes + self.dislikes
  end

  def likes
    self.videos.sum(:like_count)
  end

  def dislikes
    self.videos.sum(:dislike_count)
  end

  def comments
    self.videos.sum(:comment_count)
  end
end
