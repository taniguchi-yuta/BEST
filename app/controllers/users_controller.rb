class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_user, only: :edit
  def index
    @users = User.all
    @bests = Best.all
    @all_ranks = Best.find(Favorite.group(:best_id).order('count(best_id) desc').limit(5).pluck(:best_id))
  end

  def show
    @user = User.find(params[:id])
    @bests = Best.all
    @bests_user = @user.bests
    @all_ranks = Best.find(Favorite.group(:best_id).order('count(best_id) desc').limit(5).pluck(:best_id))
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def favorites
    @user = User.find(params[:id])
    @bests = @user.bests
    @favorite_bests = @user.favorite_bests
    @all_ranks = Best.find(Favorite.group(:best_id).order('count(best_id) desc').limit(5).pluck(:best_id))
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :sex, :age, :introduction)
  end

  def reject_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end
end
