class CampaignNotifierMailer < ApplicationMailer
  def issue_invites(emails)
    emails.each do |address|
      mail(to: address,
           subject: 'You have been invited to a campaign'
      )
    end
  end
end
