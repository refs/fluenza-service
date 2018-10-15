# -*- encoding : utf-8 -*-
class SlugOnInfluencerAndAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :influencers, :slug, :string

    add_index :influencers, :slug, unique: true
  end
end
