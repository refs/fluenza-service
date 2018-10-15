# -*- encoding : utf-8 -*-
class CreateVideoSnapshots < ActiveRecord::Migration[5.0]
  def change
    create_table :video_snapshots do |t|

      t.timestamps
    end
  end
end
