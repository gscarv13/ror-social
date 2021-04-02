class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, class_name: 'Friendship', foreign_key: 'sent_to_id'

  def friends_list
    Friendship.where(user: self, status: true).pluck(:sent_to_id)
  end

  def pending_confirmation
    friends.where(sent_to: self, status: false).pluck(:user_id)
  end

  def friendship_requested
    friendships.where(user: self, status: false).pluck(:sent_to_id)
  end
end
