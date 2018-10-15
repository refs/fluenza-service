class AddImageToIgPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :standard_res_image, :string
  end
end
