# -*- encoding : utf-8 -*-

class ComputeInfluencerScore
  include Sidekiq::Worker
  sidekiq_options :retry => 10

  def perform(id)
    influencer = Influencer.find(id)
    influencer.update_attributes(score: influencer.get_score)
    self.class.perform_in(DateTime.now + 1.day, id)
  end
end
