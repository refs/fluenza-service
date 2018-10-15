# -*- encoding : utf-8 -*-

class CaptureYoutubeAccountSnapshot
  include Sidekiq::Worker
  sidekiq_options :retry => 10

  def perform(id)
    account = Account.find(id)
    Rails.logger.warn('WAIT 24 HOURS BEFORE PERFORM') if account.eligible_to_perform
    account.snap_it
    account.report_snapshot_to_slack
    account.fetch_videos
    account.update_category
    account.data_load_completed
    self.class.perform_in(DateTime.tomorrow.beginning_of_day + 5.minutes, account.id)
  end
end
