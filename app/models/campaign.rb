class Campaign < ApplicationRecord
  belongs_to :user
  # TODO: use polymorphic associations here
  has_many :user_media_content
  has_many :posts, through: :user_media_content
  has_many :videos, through: :user_media_content

  # NOTE: related models such as post or video are automatically
  #               maintained / added with the back-linking strategy.

  validates :name, presence: true

  # TODO: abstract
  def views_fluctuation
    dataset = {}
    videos.each_with_index do |video, i|
      tmp = group_and_sum_video_attribute(video, 'view_count')
      dataset[i] = series_formatter_absolute(tmp)
    end
    dataset
  end

  # TODO: abstract
  def instagram_likes
    dataset = {}
    posts.each_with_index do |post, i|
      tmp = group_and_sum_post_attribute(post, 'like_count')
      dataset[i] = series_formatter_absolute(tmp)
    end
    dataset
  end

  # TODO: abstract
  def state
    if DateTime.now < start_date
      0
    elsif DateTime.now > start_date && DateTime.now < end_date
      1
    else
      2
    end
  end

  private

  # TODO: abstract
  def campaign_videos_view_count
    count = 0
    videos.each do |video|
      count += video.view_count
    end
    count
  end

  # TODO: abstract
  def group_and_sum_video_attribute(video, target_attributes)
    video.video_snapshots.where('created_at > ?', start_date - 1.days)
         .group("DATE_TRUNC('day', created_at)")
         .sum(target_attributes.to_sym)
         .sort
         .reverse
  end

  # TODO: abstract
  def group_and_sum_post_attribute(post, target_attributes)
    post.post_snapshots.where('created_at > ?', start_date - 1.days)
        .group("DATE_TRUNC('day', created_at)")
        .sum(target_attributes.to_sym)
        .sort
        .reverse
  end

  # TODO: abstract
  def series_formatter_absolute(raw_data)
    raw_data.each_with_index do |el, i|
      raw_data[i][0] = el[0].strftime('%d/%m/%y')
    end
  end
end
