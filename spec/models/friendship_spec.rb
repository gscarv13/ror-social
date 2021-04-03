require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before(:all) do
    @current_user = FactoryBot.create(:user)
    @friend = FactoryBot.create(:user)
    @friendship = Friendship.create(user: @current_user, sent_to: @friend, status: false)
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:sent_to_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:sent_to) }
  end

  describe 'add friend' do
    it 'add current_user id as user_id at Friendships table' do
      expect(@friendship.user_id).to be(@current_user.id)
    end

    it 'add friend id as sent_to_id at Friendships table' do
      expect(@friendship.sent_to_id).to be(@friend.id)
    end

    it 'should have status false' do
      expect(@friendship.status).to be false
    end
  end

  describe '#saved?' do
    it 'should return true for friendships persisted on the database' do
      expect(@friendship.saved?).to be true
    end

    it 'should return false if not commited to the database' do
      @new_friendship = Friendship.new(user_id: 10, sent_to_id: 11, status: false)

      expect(@new_friendship.saved?).to be false
    end
  end
end
