class PostCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
  	@post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @post_comments = @post.post_comments
	  @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comment.save
    @post.create_notification_comment!(current_user, @comment.id)
  end

  def destroy
  	post = PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments
  end
    private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
