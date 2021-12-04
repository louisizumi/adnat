class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shifts
  belongs_to :organisation

  validates :full_name, presence: true, format: { with: /\A([a-z]+[ \-.,']* )+\z/i }
end
