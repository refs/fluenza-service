class AddScoreToInfluencer < ActiveRecord::Migration[5.0]
  def change
    add_column :influencers, :score, :float
  end
end
