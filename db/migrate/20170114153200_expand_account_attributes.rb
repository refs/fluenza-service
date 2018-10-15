# -*- encoding : utf-8 -*-
class ExpandAccountAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :youtube_channel_id, :string
  end
end
