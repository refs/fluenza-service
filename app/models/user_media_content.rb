class UserMediaContent < ApplicationRecord
  belongs_to :campaign
  belongs_to :post, optional: true
  belongs_to :video, optional: true
end
