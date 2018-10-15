# -*- encoding : utf-8 -*-
class CreateAccount < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :type
    end
  end
end
