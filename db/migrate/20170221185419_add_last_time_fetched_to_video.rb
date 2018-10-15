# -*- encoding : utf-8 -*-
class AddLastTimeFetchedToVideo < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :last_time_fetched, :datetime
  end
end
