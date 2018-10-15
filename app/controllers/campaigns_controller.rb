# -*- encoding : utf-8 -*-

class CampaignsController < ApplicationController
  def create
    campaign = Campaign.new(campaign_params)
    campaign.user_id = params[:user_id]
    if campaign.save
      redirect_to profile_path
    else
      redirect_to new_user_campaign_path(current_user), :flash => { :validation => 'Title has to be present.' }
    end
  end

  def new
    @campaign = Campaign.new()
    @user = current_user
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def edit
    @campaign = Campaign.find(params[:id])
    @user = current_user
  end

  def update
    campaign = Campaign.find(params[:id])
    if campaign.update_attributes(campaign_params)
      redirect_to user_campaign_path(campaign)
    else
      head :unprocessable_entity
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :budget, :start_date,
                                     :end_date, :backlinks, :briefing,
                                     :comments, :post_ids => [], :video_ids => [])
  end
end
