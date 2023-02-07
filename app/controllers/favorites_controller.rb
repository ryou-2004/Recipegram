class FavoritesController < ApplicationController
  # いいねするとき
  def create
    logger.debug('aaaaaa')
    logger.debug(params[:recipe_id])
    current_user.favorite(params[:recipe_id],current_user.id)
    redirect_to request.referer
  end
  # いいね外すとき
  def destroy
    current_user.unfavorite(params[:recipe_id],current_user.id)
    redirect_to request.referer
  end
  # いいねをしているツイート一覧
  def followings
    user = User.find(params[:user_id])
    @user = user
    @recipes = user.favorecipes
  end
  # いいねをしている人一覧
  def followers
    recipe = Recipe.find(params[:recipe_id])
    @recipe = recipe
    @users = recipe.users
  end
end
