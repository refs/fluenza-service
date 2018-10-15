# -*- encoding : utf-8 -*-
module UsersMixin
  extend ActiveSupport::Concern

  def admin?
    self.has_role?(:admin)
  end
end
