# -*- encoding : utf-8 -*-

class CaptureInstagramAccountSnapshot
  include Sidekiq::Worker
  include Snapshots
  sidekiq_options :retry => 20

  # Disclamer: This job won't be taking post snapshots as the Instagram API changed.
  # It needs to be adapted to reflect such changes.
  # Changes will be done on the Snapshots module
  def perform(id)
    account = InstagramAccount.find(id)
    response = HTTParty.get("https://www.instagram.com/#{account.ig_username}/?__a=1")
    account.update_attributes(ig_profile_picture: response["user"]["profile_pic_url"])
    media = JSON.parse(response.body)

    # The IG pagination API changed. Uncomment when fixed.
    # fetch_posts(media, account, response)
    # update_top_level_properties(account, response)

    account.data_load_completed
    self.class.perform_in(DateTime.tomorrow.beginning_of_day + 5.minutes, account.id)
  end
end
