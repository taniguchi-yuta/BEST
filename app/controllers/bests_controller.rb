class BestsController < ApplicationController
  def new
    @best = Best.new
  end

  def create
    @best = Best.new(best_params)
    @best.user_id = current_user.id
    @best.save
    redirect_to bests_path
  end

  def index
    @bests = Best.all
  end

  def show
    @best = Best.find(params[:id])
    @user = @best.user
  end

  def edit
    @best = Best.find(params[:id])
  end

  def update
    @best = Best.find(params[:id])
    @best.update(best_params)
    redirect_to best_path(@best.id)
  end

  def destroy
    @best = Best.find(params[:id])
    @best.destroy
    redirect_to bests_path
  end

  def genre_search
    @bests = Best.where(genre: '0')
  end

  private

  def best_params
    params.require(:best).permit(:best_image, :best_name, :best_url, :recommend, :genre)
  end
end
