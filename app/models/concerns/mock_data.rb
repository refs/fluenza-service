# -*- encoding : utf-8 -*-
module MockData
  extend ActiveSupport::Concern

  def mock_snapshots
    1.upto(20) do |i|
      self.account_snapshots.create(
        youtube_channel_comment_count: self.youtube_channel_comment_count,
        youtube_channel_subscriber_count: self.youtube_channel_subscriber_count + rand(3..5)*rand(54..123),
        youtube_channel_video_count: self.youtube_channel_video_count + rand(1..4),
        youtube_channel_view_count: youtube_channel_view_count + i*35000,
        fluenza_views_count: self.fluenza_views_count,
        created_at: DateTime.now - i.days
      )

      p "done!"
    end
  end
end
