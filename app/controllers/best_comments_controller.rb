class BestCommentsController < ApplicationController
  before_action :reject_user, only: :destory
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

  def reject_user
    @best_comment = BestComment.find(params[:best_id])
    redirect_to best_path(current_user.id) unless @best_comment.user == current_user
  end
end
