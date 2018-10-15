class AddOverallLikesToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :ig_overall_likes, :bigint
  end
end
