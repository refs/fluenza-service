module InstagramScores
  extend ActiveSupport::Concern

  def follower_score
    follower_score = Math.log(self.account.ig_follows.to_f / limits["followers"]) + 10
    follower_score < 0 ? 0 : follower_score
  end
end
