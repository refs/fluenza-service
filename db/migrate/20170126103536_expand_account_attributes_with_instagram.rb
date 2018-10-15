# -*- encoding : utf-8 -*-
class ExpandAccountAttributesWithInstagram < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :instagram_authorization_token, :string
  end
end
