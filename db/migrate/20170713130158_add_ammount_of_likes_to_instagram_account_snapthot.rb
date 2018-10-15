class AddAmmountOfLikesToInstagramAccountSnapthot < ActiveRecord::Migration[5.0]
  def change
    add_column :account_snapshots, :ig_overall_likes, :bigint
  end
end
