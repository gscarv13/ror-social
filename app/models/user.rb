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
    Friendship.where(user: self)
  end

  def pending_confirmation
    friends.map { |f| f.user unless f.status }
  end

  def friendship_requested
    arr = friendships.map { |f| f.sent_to unless f.status && !f.status.nil? }

    arr.all?(nil) ? [] : arr
  end

  def friend?(user)
    Friendship.where(user: self, sent_to: user).empty? ? false : true
  end
end
