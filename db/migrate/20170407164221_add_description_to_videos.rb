class AddDescriptionToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :description, :string
  end
end
