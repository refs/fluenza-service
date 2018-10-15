namespace :daily do
  desc " >> updates accounts categories on a daily basis"
  task :update_youtube_accounts_categories => :environment do
    YoutubeAccount.all.each do |account|
      category = account.videos.group(:category_id).count.sort_by { |h| h[1]}.reverse.flatten.select.with_index { |_, i| i.even? }
      account.update_attributes(category: category.first)
    end
  end
end
