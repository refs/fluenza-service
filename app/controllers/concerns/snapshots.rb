# -*- encoding : utf-8 -*-

# Small API to handle external resources fetch and persistence.
module Snapshots
  extend ActiveSupport::Concern

  def refresh_instagram(account)
    response = HTTParty.get("https://www.instagram.com/#{account.ig_username}/?__a=1")
    account.update_attributes(ig_profile_picture: response["user"]["profile_pic_url"])
    media = JSON.parse(response.body)
    fetch_posts(media, account, response)
    update_top_level_properties(account, response)
    account.data_load_completed
  end

  def refresh_youtube(account)
    account.snap_it
  end

  # The trickery that follows is due to both endpoints being used here return significantly different data structures.
  # endpoints: 
  #   - https://www.instagram.com/alexungr/?__a=1
  #   - https://www.instagram.com/graphql/query/?query_id=17888483320059182&variables={...}
  # don't make any effort understanding this code.

  def self.fetch_posts(ig_acount_id)
    account = InstagramAccount.find_by_id(ig_acount_id)
    response = HTTParty.get("https://www.instagram.com/#{account.ig_username}/?__a=1")
    media = JSON.parse(response.body)
    json_response = JSON.parse(response.body)
    user_id = JSON.parse(response.body)["user"]["id"]

    loop do
      if media.length == 2
        media["user"]["media"]["nodes"].each do |post|
          capture_post_snapshot(post, account) # TODO wire this to actually persist the post data
          puts post["id"]
        end
        break if !media['user']['media']['page_info']['has_next_page']
        media = JSON.parse(next_page(json_response["user"]["id"], json_response['user']['media']['page_info']['end_cursor']).body)["data"]["user"]["edge_owner_to_timeline_media"]["edges"]
      else
        media.each do |post|
          capture_post_snapshot(post["node"], account) # TODO wire this to actually persist the post data
          puts post["node"]["id"]
        end
        break if (!response["user"].nil? && !response['user']['media']['page_info']['has_next_page']) || (!response["data"].nil? && !response["data"]["user"]["edge_owner_to_timeline_media"]["page_info"]["has_next_page"])
        end_cursor = set_end_cursor(response, JSON.parse(response.body))
        response = next_page(user_id, end_cursor)
        media = response["data"]["user"]["edge_owner_to_timeline_media"]["edges"]
      end
    end
  end

  # TODO motivation behind a hardcoded query_id: https://stackoverflow.com/a/47243409/2295410
  # This is a temporary solution and most likely will change in the future.
  # have a look at this: https://github.com/tomkdickinson/Instagram-Search-API-Python/blob/493d834f00bdc7bd3111d53caba28f413b909519/instagram_search.py#L190-L197
  def self.next_page(user_id, end_cursor)
    query_id = 17888483320059182
    max_per_page = 12
    variables = "%7B%22id%22%3A%22#{user_id}%22%2C%22first%22%3A#{max_per_page}%2C%22after%22%3A%22#{end_cursor}%22%7D"
    dest = "https://www.instagram.com/graphql/query/?query_id=17888483320059182&variables="+variables
    HTTParty.get(dest)
  end

  def self.set_end_cursor(response, body)
    if response["data"].nil?
      return body['user']['media']['page_info']['end_cursor']
    else
      return body["data"]["user"]["edge_owner_to_timeline_media"]['page_info']['end_cursor']
    end
  end

  def self.capture_post_snapshot(post, account)
    create_snapshot_from(post, account)
    update_self_attributes(post)
  end

  def self.create_snapshot_from(post, account)
    _post = Post.find_by_instagram_id(post['id'])
    if _post.nil?
      _post = create_new_post(post, account)
    end

    if !post['comments'].nil?
      post_snapshot = _post.post_snapshots.new(
        post_id: post,
        like_count: post['likes']['count'],
        comment_count: post['comments']['count']
      )
      post_snapshot.save
    else
      post_snapshot = _post.post_snapshots.new(
        post_id: post,
        like_count: post['edge_media_preview_like']['count'],
        comment_count: post["edge_media_to_comment"]['count']
      )
      post_snapshot.save
    end
  end

  def self.create_new_post(post, account)
    if !post['comments'].nil?
      p = Post.new(
        instagram_id: post['id'],
        like_count: post['likes']['count'],
        comment_count: post['comments']['count'],
        instagram_account_id: account.id,
        published_at: DateTime.strptime(post['date'].to_s, '%s')
      )
      p.description = post['caption']['text'] if !post['caption'].nil?
      p.save and return p
    else
      p = Post.new(
        instagram_id: post['id'],
        like_count: post['edge_media_preview_like']['count'],
        comment_count: post["edge_media_to_comment"]['count'],
        instagram_account_id: account.id,
        published_at: DateTime.strptime(post['taken_at_timestamp'].to_s, '%s')
      )
      p.description = post['caption']['text'] if !post['caption'].nil?
      p.save and return p
    end
  end

  def self.update_self_attributes(post)
    p = Post.find_by_instagram_id(post['id'])
    if !p.nil? && post["is_video"] != true
      if !post['comments'].nil?
        p.update_attributes(
          ig_code: post['code'],
          like_count: post['likes']['count'],
          comment_count: post['comments']['count'],
          standard_res_image: post['thumbnail_resources'][4]['src']
        )
      else
        p.update_attributes(
          ig_code: post['code'],
          like_count: post['edge_media_preview_like']['count'],
          comment_count: post["edge_media_to_comment"]['count'],
          standard_res_image: post['thumbnail_resources'][4]['src']
        )
      end
    end
  end

  def self.update_top_level_properties(account, response)
    response = HTTParty.get("https://www.instagram.com/web/search/topsearch/?query=#{account.ig_username}")
    current_user = response["users"].select {|users| users["user"]["username"] == account.ig_username}[0]["user"]
    account.account_snapshots.create(
      ig_follows: current_user["follower_count"].to_i,
      ig_overall_likes: account.influencer.likes
    )
    account.update_attributes(
      ig_follows: current_user["follower_count"].to_i,
      ig_username: current_user["username"],
      ig_overall_likes: account.influencer.likes,
      data_loaded: true
    )
  end
end