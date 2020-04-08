class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(best_id: params[:best_id])
    favorite.save
    redirect_back(fallback_location: bests_path)
  end

  def destroy
    favorite = Favorite.find_by(best_id: params[:best_id], user_id: current_user.id)
    favorite.destroy
    redirect_back(fallback_location: bests_path)
  end
end
