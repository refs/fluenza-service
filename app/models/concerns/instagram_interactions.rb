# -*- encoding : utf-8 -*-

module InstagramInteractions
  extend ActiveSupport::Concern

  def likes
    self.account.posts.sum(:like_count)
  end

  def comments
    self.account.posts.sum(:comment_count)
  end
end
