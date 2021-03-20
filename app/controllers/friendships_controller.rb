class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def add_friend
    @user = User.find_by(id: params[:id])
    @friendship = Friendship.new(user: current_user, sent_to: @user, status: false)

    redirect_to users_path if @friendship.save
  end
end
