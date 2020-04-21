class FavoritesController < ApplicationController
  def create
    @best = Best.find(params[:best_id])
    favorite = current_user.favorites.build(best_id: params[:best_id])
    favorite.save
  end

  def destroy
    @best = Best.find(params[:best_id])
    favorite = Favorite.find_by(best_id: params[:best_id], user_id: current_user.id)
    favorite.destroy
  end
end
