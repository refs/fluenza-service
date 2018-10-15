# -*- encoding : utf-8 -*-
class AddYoutubeChannelHandlerToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :youtube_channel_handler, :string
  end
end
