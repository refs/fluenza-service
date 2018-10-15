# -*- encoding : utf-8 -*-
class ExpandAccountsProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :youtube_channel_title, :string
    add_column :accounts, :youtube_channel_description, :string
    add_column :accounts, :youtube_channel_public, :boolean
    add_column :accounts, :youtube_channel_unlisted, :boolean
    add_column :accounts, :youtube_channel_view_count, :integer, limit: 8
    add_column :accounts, :youtube_channel_comment_count, :integer, limit: 8
    add_column :accounts, :youtube_channel_video_count, :integer
    add_column :accounts, :youtube_channel_subscriber_count, :integer, limit: 8
    add_column :accounts, :youtube_channel_subscriber_count_visible, :boolean
    add_column :accounts, :youtube_channel_thumbnail, :string
  end
end
