# -*- encoding : utf-8 -*-
module AccountRemoteData
  extend ActiveSupport::Concern

  def fetch_channel_by_id
    channel = Yt::Channel.new(id: self.youtube_channel_id)
  end

  def fetch_videos
    FetchYoutubeVideos.perform_async(self.youtube_channel_id)
  end
end
