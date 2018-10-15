# -*- encoding : utf-8 -*-
class AddIndexesToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_index :accounts, :youtube_channel_subscriber_count
  end
end
