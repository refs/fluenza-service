# -*- encoding : utf-8 -*-
class ExpandinfluencerAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :influencers, :platform, :string
    add_column :influencers, :title, :string
    add_column :influencers, :description, :string
  end
end
