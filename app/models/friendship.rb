class Friendship < ApplicationRecord
  belongs_to :sent_by
  belongs_to :send_to
end
