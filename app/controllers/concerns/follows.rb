# -*- encoding : utf-8 -*-

module Follows
  extend ActiveSupport::Concern

  def follow
    user = User.find(params[:user_id])
    user.profile.followings.create(
      influencer_id: params[:influencer_id]
    )
    redirect_to influencers_path
  end

  def unfollow
    user = User.find(params[:user_id])
    user.profile.followings.find_by_influencer_id(params[:influencer_id]).delete
    redirect_to profile_path
  end
end
