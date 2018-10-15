# -*- encoding : utf-8 -*-
class FetchYoutubeVideos
  include Sidekiq::Worker
  sidekiq_options :retry => 2

  def perform(id)
    # fetch only if `channel.video_count > account.youtube_channel_video_count`
    Rails.logger.info("fetching account videos")
    account = Account.find_by_youtube_channel_id(id)
    channel = Yt::Channel.new(id: id)
    channel.videos.each do |video|
      begin
        create_with_stats(video, account)
      rescue
        create_without_stats(video, account)
      end
    end
  end

  private

  def create_with_stats(v)
    Video.create(
      title: v.title,
      youtube_id: v.id,
      view_count: v.view_count,
      like_count: v.like_count,
      comment_count: v.comment_count,
      dislike_count: v.dislike_count,
      favorite_count: v.favorite_count,
      youtube_account_id: account.id
    )
  end

  def create_without_stats(v, account)
    Video.create(
      title: v.title,
      youtube_id: v.id,
      youtube_account_id: account.id
    )
  end
end
