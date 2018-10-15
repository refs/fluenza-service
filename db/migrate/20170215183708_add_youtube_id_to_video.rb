# -*- encoding : utf-8 -*-
class AddYoutubeIdToVideo < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :youtube_id, :string
  end
end
