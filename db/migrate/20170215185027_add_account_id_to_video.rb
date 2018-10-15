# -*- encoding : utf-8 -*-
class AddAccountIdToVideo < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :youtube_account_id, :integer
  end
end
