class BestCommentsController < ApplicationController
  def create
    @best = Best.find(params[:best_id])
    @best_comment = @best.best_comments.new(best_comment_params)
    @best_comment.user_id = current_user.id
    @best_comment.save
  end

  def destroy
    @best_comment = BestComment.find(params[:best_id])
    @best = @best_comment.best
    @best_comment.destroy
  end

  private

  def best_comment_params
    params.require(:best_comment).permit(:comment)
  end
end
