# -*- encoding : utf-8 -*-

module Fetchable
  extend ActiveSupport::Concern

  def fetch_youtube_channel(handler)
    channel = fetch_with_user_id(handler) || fetch_with_channel_id(handler)
    return 'No channel found' unless channel.class.to_s == 'Yt::Models::Channel'
    @youtube_influencer = find_or_initialize_youtube_influencer_from(channel)
    channel
  end

  def fetch_instagram_profile(handler)
    @instagram_influencer = find_or_initialize_instagram_influencer_from(handler)
  end

  def fetch_with_user_id(handler)
    url = "https://www.youtube.com/user/#{handler}"
    channel = Yt::Channel.new(url: url)
    channel.title
    channel
  rescue
    false
  end

  def fetch_with_channel_id(id)
    url = "https://www.youtube.com/channel/#{id}"
    channel = Yt::Channel.new(url: url)
    channel.title
    channel
  rescue
    false
  end

  def find_or_initialize_youtube_influencer_from(channel)
    account = YoutubeAccount.find_by_youtube_channel_id(channel.id)
    if !account.nil?
      influencer = account.influencer
    else
      influencer = create_influencer_from(channel)
      initialize_youtube_account(channel, params[:handler], influencer)
    end
    influencer
  end

  def find_or_initialize_instagram_influencer_from(handler)
    account = InstagramAccount.find_by_ig_username(handler)
    if !account.nil?
      influencer = account.influencer
    else
      influencer = create_influencer_from(handler)
      initialize_instagram_account(handler, influencer)
    end
    influencer
  end

  def create_influencer_from(resource)
    case resource.class.to_s
    when "Yt::Models::Channel"
      Influencer.create(platform: 'YouTube', title: resource.title,
        description: resource.description
      )
    else
      r = ig_get(resource)
      return r if r == "No Instagram account found"
      Influencer.create(platform: 'Instagram', title: r["items"][0]["user"]["username"])
    end
  end

  def initialize_youtube_account(channel, handler, influencer)
    account = influencer.account = YoutubeAccount.new(
      youtube_channel_id: channel.id,
      youtube_channel_handler: handler,
      youtube_channel_title: channel.title,
      youtube_channel_thumbnail: channel.thumbnail_url,
      youtube_channel_description: channel.description
    )
    account.save if account.valid?
  end

  def initialize_instagram_account(handler, influencer)
    r = ig_get(handler)
    return "No influencer found" if r["items"].nil?
    account = influencer.account = InstagramAccount.new(
      ig_id: r["items"][0]["user"]["id"],
      ig_username: r["items"][0]["user"]["username"]
    )
    account.save if account.valid?
  end

  private

  def ig_get(handler)
    r = HTTParty.get("https://www.instagram.com/{handler}/?__a=1")
    return "No Instagram account found" if r['items'].nil? || r['items'].empty?
    r
  end
end
