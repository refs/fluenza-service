# -*- encoding : utf-8 -*-
class AddInfluencerToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :influencer_id, :integer
  end
end
