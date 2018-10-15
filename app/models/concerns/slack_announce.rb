# -*- encoding : utf-8 -*-
module SlackAnnounce
  extend ActiveSupport::Concern

  def report_snapshot_to_slack
    SlackNotifier.perform_async(">>> *#{self.youtube_channel_title}*'s snapshot captured \n account id: *#{self.id}* \n total snapshots: *#{self.account_snapshots.count}*")
  end
end
