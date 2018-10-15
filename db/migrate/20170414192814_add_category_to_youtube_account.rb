class AddCategoryToYoutubeAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :category, :integer
  end
end
