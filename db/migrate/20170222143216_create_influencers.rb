# -*- encoding : utf-8 -*-
class CreateInfluencers < ActiveRecord::Migration[5.0]
  def change
    create_table :influencers do |t|

      t.timestamps
    end
  end
end
