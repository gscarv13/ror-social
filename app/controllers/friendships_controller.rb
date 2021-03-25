class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_friendship, only: %i[confirmation]

  def add_friend
    @friendship = Friendship.new(user: current_user, sent_to: @user, status: false)

    if @friendship.saved?
      flash[:alert] = 'Friendship already exists'
    else
      flash[:notice] = 'Friend request sent successfully'
      @friendship.save
    end

    redirect_to users_path
  end

  def confirmation
    @user = set_user

    case confirmation_params[:ok]
    when '1'
      @friendship.status = true
      @reverse = Friendship.new(user: current_user, sent_to: @user, status: true)
      @friendship.save
      @reverse.save

    when '0'
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
