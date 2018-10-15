# -*- encoding : utf-8 -*-

class User < ApplicationRecord
  include UsersMixin
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :profile
  has_many :campaigns
  belongs_to :agency
  after_create :assign_default_role, :create_profile, :generate_access_token


  def as_json(options = nil)
    super({ only: %i[id email access_token] }.merge(options || {}))
  end

  private

  def assign_default_role
    add_role(:newuser) if roles.blank?
  end

  def create_profile
    Profile.create(user: self)
  end

  def generate_access_token
    token = SecureRandom.urlsafe_base64(16)
    update_attributes(access_token: token)
  end
end
