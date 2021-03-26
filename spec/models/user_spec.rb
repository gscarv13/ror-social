require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    # create users
    15.times do
      FactoryBot.create(:user)
    end

    @user1 = User.first
    @user2 = FactoryBot.create(:user)
    @not_friend = FactoryBot.create(:user)

    # create friendships
    15.times do |i|
      Friendship.create(user_id: @user2.id, sent_to_id: i, status: true)
    end
  end

  describe '#friends_list' do
    it 'should have friends' do
      expect(@user2.friends_list).to_not be_empty
    end
    it '@user2 should be friends with @user1' do
      expect(@user2.friends_list.include?(@user1.id)).to be true
    end

    it '@user2 should not be friends with @not_friend' do
      expect(@user2.friends_list.include?(@not_friend.id)).to be false
    end
  end

  describe '#pending_confirmation' do
    it 'should not have no pending confirmation' do
      expect(@user2.pending_confirmation).to be_empty
    end

    it 'should have one request pending' do
      @test_user = FactoryBot.create(:user)
      Friendship.create(user: @test_user, sent_to: @user1, status: false)

      expect(@user1.pending_confirmation).to_not be_empty
    end
  end

  describe '#friendship_requested' do
    it 'should have no friendship_requested' do
      expect(@user2.friendship_requested).to be_empty
    end

    it 'should have one request pending' do
      @test_user2 = FactoryBot.create(:user)
      Friendship.create(user: @user1, sent_to: @test_user2, status: false)

      expect(@user1.friendship_requested).to_not be_empty
    end
  end
end
