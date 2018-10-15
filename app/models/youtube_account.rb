# -*- encoding : utf-8 -*-

class YoutubeAccount < Account
  include YoutubeInteractions
  include MockData
  include AccountData
  include AccountRemoteData
  has_many :videos, dependent: :destroy
  has_many :account_snapshots, dependent: :destroy
  after_create :capture_snapshot

  def serializable_hash(options={})
    options = {
      methods: [:youtube_channel_view_count, :youtube_channel_thumbnail]
    }
    super({only: [:youtube_channel_id,:youtube_channel_title]}.merge(options || {}))
  end

  def capture_snapshot
    CaptureYoutubeAccountSnapshot.perform_async(id)
  end
end
