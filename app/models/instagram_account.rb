# -*- encoding : utf-8 -*-

class InstagramAccount < Account
  include AccountData

  has_many :posts
  has_many :account_snapshots, dependent: :destroy
  after_create :fetch_user_media

  def serializable_hash(options={})
    super({only: [:instagram_authorization_token]}.merge(options || {}))
  end

  private

  def fetch_user_media
    CaptureInstagramAccountSnapshot.perform_async(self.id)
  end
end
