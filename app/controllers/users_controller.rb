class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_user, only: :edit
  before_action :set_user, only: [:show, :edit, :update, :favorites]
  before_action :set_q, only: [:index, :show, :favorites]
  before_action :set_all_ranks, only: [:index, :show, :favorites]
  before_action :check_guest, only: :update
  def index
    @users = User.page(params[:page]).per(7)
  end

  def show
    @bests_user = @user.bests.order(updated_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'プロフィールを編集しました'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def favorites
    @bests_favorite = @user.favorite_bests
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :sex, :age, :introduction)
  end

  def reject_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_q
    @q = Best.ransack(params[:q])
  end

  def set_all_ranks
    @all_ranks = Best.find(Favorite.group(:best_id).order(Arel.sql('count(best_id) desc')).limit(5).pluck(:best_id))
  end

  def check_guest
    if @user.email == 'guest@example.com'
      flash[:danger] = 'ゲストユーザーの編集はできません。'
      redirect_to edit_user_path(@user)
    end
  end
end
