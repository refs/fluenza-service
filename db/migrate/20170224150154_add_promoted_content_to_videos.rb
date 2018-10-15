# -*- encoding : utf-8 -*-
class AddPromotedContentToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :promoted_content, :boolean
  end
end
