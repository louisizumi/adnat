class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shifts
  belongs_to :organisation, optional: true

  validates :full_name, format: { with: /\A([a-z]+[ \-.,']*)+\z/i }, length: { in: 2..64 }, presence: true
end
