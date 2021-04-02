class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    user_hash = { user_id: [current_user, current_user.friends_list].flatten }
    @post = Post.new
    @timeline_posts = Post.all.timeline_posts(user_hash)
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
