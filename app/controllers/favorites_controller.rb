class FavoritesController < ApplicationController
  # いいねするとき
  def create
    current_user.favorite(params[:recipe_id])
    redirect_to request.referer
  end

  # いいね外すとき
  def destroy
    current_user.unfavorite(params[:recipe_id])
    redirect_to request.referer
  end

  # いいねをしているツイート一覧
  def favorecipes
    @user = User.find(params[:user_id])
    @recipes = @user.favorecipes
  end

  # いいねをしている人一覧
  def favousers
    @recipe = Recipe.find(params[:recipe_id])
    @users = @recipe.favousers
  end
end
