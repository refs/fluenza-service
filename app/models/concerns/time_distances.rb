# -*- encoding : utf-8 -*-

module TimeDistances
  extend ActiveSupport::Concern

  def hours_since_last_update
    return 25 if self.account_snapshots.empty?
    (DateTime.now.in_time_zone - self.account_snapshots.last.created_at).to_i  / 60 / 60
  end
end
