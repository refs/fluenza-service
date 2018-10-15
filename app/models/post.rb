# -*- encoding : utf-8 -*-

class Post < ApplicationRecord
  include ResourceData
  belongs_to :instagram_account
  has_many :post_snapshots, dependent: :destroy
end
