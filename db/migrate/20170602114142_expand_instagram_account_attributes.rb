class ExpandInstagramAccountAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :ig_profile_picture, :string
    add_column :accounts, :ig_follows, :integer
    add_column :accounts, :ig_followed_by, :string
    add_column :accounts, :ig_full_name, :string
    add_column :accounts, :ig_website, :string
    add_column :accounts, :ig_media, :string
    add_column :accounts, :ig_id, :string
  end
end
