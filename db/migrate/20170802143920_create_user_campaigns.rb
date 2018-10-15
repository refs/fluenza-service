class CreateUserCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :user_campaigns do |t|
      t.integer :user_id
      t.integer :campaign_id

      t.timestamps
    end
  end
end
