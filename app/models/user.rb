class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :confirmed_friendships, -> { where status: true }, class_name: :Friendship
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where status: false }, class_name: :Friendship
  has_many :pending_requests, through: :pending_friendships, source: :friend
end
