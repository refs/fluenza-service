# -*- encoding : utf-8 -*-
class Admin::UsersController < Admin::ApplicationController
  def index
    @user_count = User.count
  end

  def show
    @user = User.find(params[:id])
    @youtube_auth_url = Yt::Account.new(
      scopes: YOUTUBE_SCOPES,
      redirect_uri: YOUTUBE_REDIRECT_URI)
      .authentication_url
  end
end
