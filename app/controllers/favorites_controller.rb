class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite
    if favorite.save
      flash[:notice] = "Successfully favorited \"#{@post.title}\""
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Sorry, there was a problem favoriting the post."
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find(params[:id])
    authorize favorite
    if favorite.destroy
      flash[:notice] = "Successfully unfavorited \"#{@post.title}\""
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Sorry, there was a problem unfavoriting the post."
    end
  end

end
