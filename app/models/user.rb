# frozen_string_literal: true

class User < ApplicationRecord
  DEFAULT_PROFILE_URL = 'https://i.stack.imgur.com/xHWG8.jpg'

  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :articles, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def generate_jwt
    Warden::JWTAuth::UserEncoder
      .new
      .call(self, :user, nil)
      .first
  end

  def picture_url
    image_url || DEFAULT_PROFILE_URL
  end
end
