# -*- encoding : utf-8 -*-

class CaptureVideoSnapshot
  include Sidekiq::Worker
  sidekiq_options :retry => 10

  def perform(id)
    video = Video.find(id)
    video.snap_it
    if video.on_active_campaign
      self.class.perform_in(DateTime.tomorrow.beginning_of_day + 10.minutes, id) and return
    elsif video.published_at > 7.days.ago
      self.class.perform_in(DateTime.tomorrow.beginning_of_day + 10.minutes, id)
    elsif video.published_at > 30.days.ago
      self.class.perform_in(1.week, id)
    else
      self.class.perform_in(1.month, id)
    end
  end
end
