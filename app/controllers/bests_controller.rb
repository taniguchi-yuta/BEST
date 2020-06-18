class BestsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destory]
  before_action :reject_user, only: [:edit, :destroy]
  before_action :set_best, only: [:show, :edit, :update, :destroy]
  before_action :set_q, only: [:index, :show]
  before_action :set_all_ranks, only: [:index, :show]
  def new
    @best = Best.new
  end

  def create
    @best = Best.new(best_params)
    @best.user_id = current_user.id
    if @best.save
      redirect_to bests_path
      flash[:notice] = '新規投稿しました。'
    else
      render :new
    end
  end

  def index
    @bests = @q.result.order(updated_at: :desc).page(params[:page]).per(9)
  end

  def show
    @user = @best.user
    @best_comment = BestComment.new
    @best_comments = @best.best_comments
  end

  def edit
  end

  def update
    if @best.update(best_params)
      redirect_to best_path(@best.id)
      flash[:notice] = 'BESTを編集しました'
    else
      render :edit
    end
  end

  def destroy
    @best.destroy
    redirect_to bests_path
    flash[:error] = 'BESTを削除しました。'
  end

  private

  def best_params
    params.require(:best).permit(:best_image, :best_name, :best_url, :recommend, :genre)
  end

  def reject_user
    @best = Best.find(params[:id])
    redirect_to user_path(current_user.id) unless @best.user == current_user
  end

  def set_best
    @best = Best.find(params[:id])
  end

  def set_q
    @q = Best.ransack(params[:q])
  end

  def set_all_ranks
    @all_ranks = Best.create_all_ranks
  end
end
