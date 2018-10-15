class CreateUserMediaContents < ActiveRecord::Migration[5.0]
  def change
    create_table :user_media_contents do |t|
      t.integer :campaign_id
      t.integer :post_id
      t.integer :video_id

      t.timestamps
    end
  end
end
