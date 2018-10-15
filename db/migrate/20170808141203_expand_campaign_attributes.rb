class ExpandCampaignAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :budget, :float
    add_column :campaigns, :comments, :string
  end
end
