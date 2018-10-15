class ExpandVideoRemoteProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :category_id, :integer
    add_column :videos, :published_at, :datetime
  end
end
