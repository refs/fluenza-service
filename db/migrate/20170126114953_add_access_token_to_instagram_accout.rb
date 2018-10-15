# -*- encoding : utf-8 -*-
class AddAccessTokenToInstagramAccout < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :instagram_access_token, :string
  end
end
