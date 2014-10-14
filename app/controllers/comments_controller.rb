class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
    authorize @comment
    
    if @comment.save
      redirect_to [@post.topic, @post]
    else
      redirect_to [@post.topic, @post]
      flash[:error] = "There was an error creating the comment."
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error deleting the comment."
      redirect_to [@post.topic, @post]
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end
