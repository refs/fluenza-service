class ExpandUserMediaContentAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :user_media_contents, :budget, :float
    add_column :user_media_contents, :annotations, :string
  end
end
