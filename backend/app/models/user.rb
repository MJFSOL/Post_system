class User < ApplicationRecord
  has_many :products, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # optional validations
  validates :email, presence: true, uniqueness: true
end
