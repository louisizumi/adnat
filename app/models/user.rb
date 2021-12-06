class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shifts
  has_many :employments
  has_many :organisations, through: :employments

  validates :full_name, format: { with: /\A([a-z]+[ \-.,']*)+\z/i }, length: { in: 2..64 }, presence: true
end
