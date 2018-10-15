# -*- encoding : utf-8 -*-
class CreateAccountSnapshots < ActiveRecord::Migration[5.0]
  def change
    create_table :account_snapshots do |t|

      t.timestamps
    end
  end
end
