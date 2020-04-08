class BestCommentsController < ApplicationController
  def create
    @best = Best.find(params[:best_id])
    @best_comment = @best.best_comments.new(best_comment_params)
    @best_comment.user_id = current_user.id
    @best_comment.save
    redirect_back(fallback_location: best_path(@best))
  end

  def destroy
    @best_comment = BestComment.find(params[:best_id])
    @best_comment.destroy
    redirect_back(fallback_location: bests_path)
  end

  private

  def best_comment_params
    params.require(:best_comment).permit(:comment)
  end
end
