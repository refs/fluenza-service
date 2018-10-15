# -*- encoding : utf-8 -*-
class ExpandAccountSnapshotAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :account_snapshots, :youtube_account_id, :integer
    add_column :account_snapshots, :instagram_account_id, :integer
    add_column :account_snapshots, :youtube_channel_view_count, :integer
    add_column :account_snapshots, :youtube_channel_comment_count, :integer
    add_column :account_snapshots, :youtube_channel_video_count, :integer
    add_column :account_snapshots, :youtube_channel_subscriber_count, :integer
    add_column :account_snapshots, :fluenza_views_count, :integer
  end
end
