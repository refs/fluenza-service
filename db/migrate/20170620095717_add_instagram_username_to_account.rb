class AddInstagramUsernameToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :ig_username, :string
  end
end
