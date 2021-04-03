class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @pending = current_user.pending_confirmation
    @requested = current_user.friendship_requested
    @friend_list = current_user.friends_list
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
