class BestsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destory]
  before_action :reject_user, only: :edit
  def new
    @best = Best.new
  end

  def create
    @best = Best.new(best_params)
    @best.user_id = current_user.id
    if @best.save
      redirect_to bests_path
    else
      render :new
    end
  end

  def index
    @q = Best.ransack(params[:q])
    @bests = @q.result.order(updated_at: :desc)
    @all_ranks = Best.find(Favorite.group(:best_id).order('count(best_id) desc').limit(5).pluck(:best_id))
  end

  def show
    @best = Best.find(params[:id])
    @q = Best.ransack(params[:q])
    @bests = @q.result
    @user = @best.user
    @best_comment = BestComment.new
    @best_comments = @best.best_comments
    @all_ranks = Best.find(Favorite.group(:best_id).order('count(best_id) desc').limit(5).pluck(:best_id))
  end

  def edit
    @best = Best.find(params[:id])
  end

  def update
    @best = Best.find(params[:id])
    if @best.update(best_params)
      redirect_to best_path(@best.id)
    else
      render :edit
    end
  end

  def destroy
    @best = Best.find(params[:id])
    @best.destroy
    redirect_to bests_path
  end

  private

  def best_params
    params.require(:best).permit(:best_image, :best_name, :best_url, :recommend, :genre)
  end

  def reject_user
    @best = Best.find(params[:id])
    redirect_to user_path(current_user.id) unless @best.user == current_user
  end
end
