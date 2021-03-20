class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :friends, class_name: 'Friendship', foreign_key: 'sent_to_id'

  def friends_list
    friends_array = friendships.map { |f| f.sent_to if f.status }
    friends_array << friends.map { |f| f.user if f.status }
    friends_array.compact.flatten
  end

  def pending_confirmation
    friends.map { |f| f.user unless f.status }
  end

  def friendship_requested
    friendships.map { |f| f.sent_to unless f.status }
  end

  def confirm_friend(user)
    friendship = friends.find { |f| f.user == user }
    friendship.status = true
    friendship.save
  end

  def friend?(user)
    friends_list.include?(user)
  end
end
