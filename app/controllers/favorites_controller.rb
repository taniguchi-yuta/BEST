class FavoritesController < ApplicationController
  before_action :set_best, only: [:create, :destroy]
  def create
    favorite = current_user.favorites.build(best_id: params[:best_id])
    favorite.save
  end

  def destroy
    favorite = Favorite.find_by(best_id: params[:best_id], user_id: current_user.id)
    favorite.destroy
  end

  private

  def set_best
    @best = Best.find(params[:best_id])
  end
end
