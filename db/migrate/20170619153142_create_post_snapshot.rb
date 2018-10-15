# -*- encoding : utf-8 -*-
class CreatePostSnapshot < ActiveRecord::Migration[5.0]
  def change
    create_table :post_snapshots do |t|

      t.timestamps
    end
  end
end
