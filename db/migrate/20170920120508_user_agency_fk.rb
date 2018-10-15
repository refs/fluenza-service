class UserAgencyFk < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :agency_id, :integer
    add_column :users, :name, :string
  end
end
