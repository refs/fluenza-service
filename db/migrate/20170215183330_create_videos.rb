# -*- encoding : utf-8 -*-
class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :title

      t.timestamps
    end
  end
end
