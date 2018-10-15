class ExpandPostSnapshotAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :post_snapshots, :post_id, :integer
    add_column :post_snapshots, :like_count, :integer
    add_column :post_snapshots, :comment_count, :integer
    add_column :post_snapshots, :description, :string

    add_index :post_snapshots, :post_id
  end
end
