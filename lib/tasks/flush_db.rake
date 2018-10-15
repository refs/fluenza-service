namespace :db do
  desc " >> flush the content from the database"
  task :flush => :environment do
    Post.destroy_all
    Account.destroy_all
    Influencer.destroy_all
    ss = Sidekiq::ScheduledSet.new
    ss.clear
  end
end
