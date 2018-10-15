# -*- encoding : utf-8 -*-
class ExpandVideoAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :view_count, :integer
    add_column :videos, :comment_count, :integer
    add_column :videos, :like_count, :integer
    add_column :videos, :dislike_count, :integer
    add_column :videos, :favorite_count, :integer
  end
end
