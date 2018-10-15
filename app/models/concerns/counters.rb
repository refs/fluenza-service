# -*- encoding : utf-8 -*-
module Counters
  extend ActiveSupport::Concern

  def increase_fluenza_view_count
    self.update_attributes(
      fluenza_views_count: self.fluenza_views_count + 1
    )
  end
end
