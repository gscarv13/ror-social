class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_friendship, except: %i[add_friend]

  def add_friend
    @friendship = Friendship.new(user: current_user, sent_to: @user, status: false)

    redirect_to users_path if @friendship.save
  end

  def confirm
    @friendship.status = true
    redirect_to users_path if @friendship.save
  end

  def refuse
    @user = set_user
    @friendship = Friendship.find_by(user: @user, sent_to: current_user)
    @friendship.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def set_friendship
    @friendship = Friendship.find_by(user: @user, sent_to: current_user)
  end
end
