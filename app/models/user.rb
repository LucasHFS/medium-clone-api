class User < ApplicationRecord
  
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :jwt_authenticatable, jwt_revocation_strategy: self

  def generate_jwt
    Warden::JWTAuth::UserEncoder
      .new
      .call(self, :user, nil)
      .first
  end 
end
