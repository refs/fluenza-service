# -*- encoding : utf-8 -*-
class Oauth::CallBacksController < Oauth::ApplicationController
  def youtube_handler
    current_user.update_attributes(
      youtube_auth_token: params[:code]
    )
    redirect_to user_path(current_user)
  end

  def instagram_handler
    response = Instagram.get_access_token(params[:code], :redirect_uri => INSTAGRAM_REDIRECT_URI)
    access_token = response.access_token
    current_user.update_attributes(
      instagram_auth_token: access_token
    )
    redirect_to user_path(current_user)
  end
end
