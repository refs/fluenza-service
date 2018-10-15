class AddBacklinksToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :backlinks, :string
  end
end
