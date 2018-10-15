# -*- encoding : utf-8 -*-

class UserMediaContentsController < ApplicationController

  def update
    umc = UserMediaContent.find(params[:id])
    if umc.update_attributes(user_media_content_params)
      # redirect_to user_campaign_path(umc.campaign.user, umc.campaign)
      head :ok
    end
  end

  private

  def user_media_content_params()
    params.require(:user_media_content).permit(:budget, :annotations)
  end
end
