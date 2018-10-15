# -*- encoding : utf-8 -*-

module AccountData
  extend ActiveSupport::Concern
  include SeriesAbsolutes

  def subscribers
    return [] unless account_snapshots.any?
    subscribers_from_snapshots = group_absolutes('youtube_channel_subscriber_count')
    format_absolutes(subscribers_from_snapshots).reverse
  end

  def views
    return [] unless account_snapshots.any?
    views_from_snapshots = group_absolutes('youtube_channel_view_count')
    format_absolutes(views_from_snapshots).reverse
  end

  def ig_subscribers
    return [] unless account_snapshots.any?
    followers_from_snapshots = group_absolutes('ig_follows')
    format_absolutes(followers_from_snapshots).reverse
  end

  def ig_likes
    return [] unless account_snapshots.any?
    likes_from_snapshots = group_absolutes('ig_overall_likes')
    format_absolutes(likes_from_snapshots).reverse
  end

  def update_category
    update_attributes(category: 0) if videos.count.zero?
    category = videos
               .group(:category_id).count.sort_by { |h| h[1] }
               .reverse
               .flatten
               .select.with_index { |_, i| i.even? }
    update_attributes(category: category.first)
  end

  def sponsored_content_ratio
    return { percentage: 0, quantified_content: 0 } if videos.count.zero?
    promoted_content = videos.where(promoted_content: true).count
    {
      percentage: ((promoted_content.to_f / videos.count) * 100).round(2),
      quantified_content: promoted_content
    }
  end

  def sponsored_content_views
    cohort = videos.where(promoted_content: true)
    return 0 if cohort.count.zero?
    cohort.sum(:view_count)
  end
end
