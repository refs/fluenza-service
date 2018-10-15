# -*- encoding : utf-8 -*-
class ExpandIntegerLength < ActiveRecord::Migration[5.0]
  def change
    change_column :accounts, :youtube_channel_view_count, :integer, limit: 8
  end
end
