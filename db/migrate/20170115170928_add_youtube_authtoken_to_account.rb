# -*- encoding : utf-8 -*-
class AddYoutubeAuthtokenToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :youtube_authorization_token, :string
  end
end
