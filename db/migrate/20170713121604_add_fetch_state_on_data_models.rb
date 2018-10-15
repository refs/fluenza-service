class AddFetchStateOnDataModels < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :data_loaded, :boolean, default: false
    Account.update_all(data_loaded: true)
  end
end
