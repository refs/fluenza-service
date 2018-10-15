# -*- encoding : utf-8 -*-

class Video < ApplicationRecord
  include Snapshots
  include ResourceData

  after_create :capture_snapshot
  validates :youtube_id, uniqueness: :true
  belongs_to :youtube_account
  has_many :video_snapshots, dependent: :destroy
  has_many :user_media_content
  has_many :campaigns, through: :user_media_content

  enum category_id: {
    'Film & Animation': 1,
    'Autos & Vehicles': 2,
    'Music': 10,
    'Pets & Animals': 15,
    'Sports': 17,
    'Short Movies': 18,
    'Travel & Events': 19,
    'Gaming': 20,
    'Videoblogging': 21,
    'People & Blogs': 22,
    'Comedy': 23,
    'Entertainment': 24,
    'News & Politics': 25,
    'Howto & Style': 26,
    'Education': 27,
    'Science & Technology': 28,
    'Nonprofits & Activism': 29,
    'Movies': 30,
    'Anime/Animation': 31,
    'Action/Adventure': 32,
    'Classics': 33,
    'Documentary': 35,
    'Drama': 36,
    'Family': 37,
    'Foreign': 38,
    'Horror': 39,
    'Sci-Fi/Fantasy': 40,
    'Thriller': 41,
    'Shorts': 42,
    'Shows': 43,
    'Trailers': 44
  }

  def serializable_hash(options={})
    super({only: [:youtube_id, :title]}.merge(options || {}))
  end

  def capture_snapshot
    CaptureVideoSnapshot.perform_async(self.id)
  end

  def is_sponsored
    update_attributes(promoted_content: true)
  end

  def on_active_campaign
    return false if campaigns.empty?
    @active ||= campaigns.all.map(&:state).include?(1) ? true : false
  end
end
