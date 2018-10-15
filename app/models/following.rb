# -*- encoding : utf-8 -*-

class Following < ApplicationRecord
  belongs_to :profile
  belongs_to :influencer
end
