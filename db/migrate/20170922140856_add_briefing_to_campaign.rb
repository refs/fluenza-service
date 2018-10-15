class AddBriefingToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :briefing, :string
  end
end
