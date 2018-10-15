# -*- encoding : utf-8 -*-

class Profile < ApplicationRecord
  belongs_to :user
  has_many :followings
  has_many :influencers, through: :followings
end
