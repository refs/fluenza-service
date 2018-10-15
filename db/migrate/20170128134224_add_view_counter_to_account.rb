# -*- encoding : utf-8 -*-
class AddViewCounterToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :fluenza_views_count, :integer, limit: 8, default: 0
  end
end
