# -*- encoding : utf-8 -*-

class Influencer < ApplicationRecord
  extend FriendlyId
  include InfluencerRatios
  include InstagramInteractions
  include Snapshots
  include Score

  has_one :account
  has_many :followings
  has_many :profiles, through: :followings
  # validates :title, uniqueness: true
  after_create :compute_score

  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
        :title,
        [:title, :platform]
    ]
  end

  def create_or_update_snapshot
    latest_snapshot = self.account.account_snapshots.where('created_at > ?', Date.today.beginning_of_day)
    update_snapshot(self, latest_snapshot)
  end

  private

  # TODO move away from here
  def update_snapshot(influencer, latest_snapshot)
    delete_today_posts(influencer.account)
    capture_account_snapshot_immediately(influencer.account)
  end

  def delete_today_posts(account)
    account.account_snapshots.last.delete
    if account.type == 'InstagramAccount'
      PostSnapshot.where('created_at > ?', Date.today.beginning_of_day).delete_all
    else # YouTube
      VideoSnapshot.where('created_at > ?', Date.today.beginning_of_day).delete_all
    end
  end

  def capture_account_snapshot_immediately(account)
    if account.type == 'InstagramAccount'
      refresh_instagram(account)
    else
      refresh_youtube(account)
    end
  end

  def compute_score
    ComputeInfluencerScore.perform_in(10.minutes, self.id)
  end
end
