class AddTimeStampsOnAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :created_at, :datetime
    add_column :accounts, :updated_at, :datetime
  end
end
