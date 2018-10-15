class CreateFollowing < ActiveRecord::Migration[5.0]
  def change
    create_table :followings do |t|
      t.integer :profile_id
      t.integer :influencer_id

      t.timestamps
    end
  end
end
