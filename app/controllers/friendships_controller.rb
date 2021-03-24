class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_friendship, only: %i[confirmation]

  def add_friend
    @friendship = Friendship.new(user: current_user, sent_to: @user, status: false)

    redirect_to users_path if @friendship.save
  end

  def confirmation
    case confirmation_params[:ok]
    when '1'
      @friendship.status = true
      @friendship.save
    when '0'
      @user = set_user
      @friendship.destroy
    end

    redirect_to users_path
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def set_friendship
    @friendship = Friendship.find_by(user: @user, sent_to: current_user)
  end

  def confirmation_params
    params.permit(:id, :ok)
  end
end
