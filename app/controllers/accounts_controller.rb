# -*- encoding : utf-8 -*-

class AccountsController < ApplicationController
  include Fetchable

  def index
    if params[:handler].present?
      populate_search_results
      render 'search_results'
    else
      @recently_added_influencers = Influencer.last(5)
    end
  end

  def show
    @account = Account.find(params[:id])
    @account.increase_fluenza_view_count
    case @account.type
    when 'YoutubeAccount'
      render 'youtube_account'
    else
      'nothing to show'
    end
  end

  def destroy
    account = Account.find(params[:id])
    redirect_to user_path(User.find(params[:user_id])) if account.destroy
  end

  private

  def populate_search_results
    @search_results = {}
    @search_results[:youtube] = fetch_youtube_channel(params[:handler])
    @search_results[:instagram] = fetch_instagram_profile(params[:handler])
    @search_results[:youtube_influencer] = @youtube_influencer
    @search_results[:instagram_influencer] = @instagram_influencer
  end
end
