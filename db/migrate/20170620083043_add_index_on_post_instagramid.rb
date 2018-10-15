class AddIndexOnPostInstagramid < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, :instagram_id
  end
end
