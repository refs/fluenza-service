# -*- encoding : utf-8 -*-

module Snapshots
  extend ActiveSupport::Concern

  def snap_it
    case self.class.to_s
    when 'YoutubeAccount'
      snap_and_update_youtube_channel
    when 'Video'
      snap_and_update_video
    else
      raise
    end
  end

  private

  def snap_and_update_youtube_channel
    latest_account_version = Yt::Channel.new(id: youtube_channel_id)
    account_snapshots.create(
      youtube_channel_view_count: latest_account_version.view_count,
      youtube_channel_comment_count: latest_account_version.comment_count,
      youtube_channel_video_count: latest_account_version.video_count,
      youtube_channel_subscriber_count: latest_account_version.subscriber_count,
      fluenza_views_count: fluenza_views_count
    )
    update_attributes(
      youtube_channel_view_count: latest_account_version.view_count,
      youtube_channel_comment_count: latest_account_version.comment_count,
      youtube_channel_video_count: latest_account_version.video_count,
      youtube_channel_subscriber_count: latest_account_version.subscriber_count,
      latest_snapshot_date: DateTime.now.in_time_zone
    )
  end

  def snap_and_update_video
    begin
      latest_video_version = Yt::Video.new(id: youtube_id)
      video_snapshots.create(
        view_count: latest_video_version.view_count,
        comment_count: latest_video_version.comment_count,
        like_count: latest_video_version.like_count,
        dislike_count: latest_video_version.dislike_count,
        favorite_count: latest_video_version.favorite_count
      )
      update_attributes(
        view_count: latest_video_version.view_count,
        comment_count: latest_video_version.comment_count,
        like_count: latest_video_version.like_count,
        dislike_count: latest_video_version.dislike_count,
        favorite_count: latest_video_version.favorite_count,
        description: latest_video_version.description,
        published_at: latest_video_version.published_at,
        category_id: latest_video_version.category_id.to_i
      )
    end
  rescue
    puts ' WARNING - NO DATA AVAILABLE, JOB RE-SCHEDULED '
  end
end
