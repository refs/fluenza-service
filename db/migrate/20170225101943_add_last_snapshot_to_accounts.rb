# -*- encoding : utf-8 -*-
class AddLastSnapshotToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :latest_snapshot_date, :datetime
  end
end
