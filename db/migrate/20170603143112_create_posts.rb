class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :instagram_account_id

      t.timestamps
    end
  end
end
