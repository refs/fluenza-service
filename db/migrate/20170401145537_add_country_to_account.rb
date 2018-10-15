# -*- encoding : utf-8 -*-
class AddCountryToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :country, :string
  end
end
