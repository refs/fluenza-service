# -*- encoding : utf-8 -*-
class ExpandUserProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :youtube_auth_token, :string
    add_column :users, :instagram_auth_token, :string
  end
end
