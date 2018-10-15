namespace :data do
  desc " >> flags videos as sponsored content"
  task :tag_sponsored_videos => :environment do
    cohort = Video.where(promoted_content: nil).or(Video.where(promoted_content: false)).where('description ~* ?', "/sponsor|werbung|(product.*placement)/i")
    cohort.update_all(promoted_content: true)
  end
end
