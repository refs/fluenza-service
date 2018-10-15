class AddIgCodeToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :ig_code, :string
  end
end
