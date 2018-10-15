namespace :init do
  desc " >> initializes user profiles"
  task :profiles => :environment do
    User.all.each do |user|
      Profile.create(user: user)
    end
    "[>> All done]"
  end
end
