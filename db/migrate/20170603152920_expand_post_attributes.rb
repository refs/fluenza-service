class ExpandPostAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :like_count, :integer
    add_column :posts, :instagram_id, :string
    add_column :posts, :comment_count, :integer
    add_column :posts, :description, :string
  end
end
