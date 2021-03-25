class Friendship < ApplicationRecord
  validates :user_id, presence: true
  validates :sent_to_id, presence: true

  belongs_to :user
  belongs_to :sent_to, class_name: 'User'
end
