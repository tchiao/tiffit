class Topics::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @topic = @post.topic
    @comments = @post.comments.all
    @comment = @post.comments.new
    authorize @topic
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post
       
    if @post.save
      @post.create_vote
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash.now[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      @post.create_vote
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash.now[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted."
      redirect_to @topic
    else
      flash.now[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
