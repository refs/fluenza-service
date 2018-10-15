# -*- encoding : utf-8 -*-
class ExpandVideoSnapshtAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :video_snapshots, :video_id, :integer
    add_column :video_snapshots, :view_count, :integer
    add_column :video_snapshots, :comment_count, :integer
    add_column :video_snapshots, :like_count, :integer
    add_column :video_snapshots, :dislike_count, :integer
    add_column :video_snapshots, :favorite_count, :integer
  end
end
