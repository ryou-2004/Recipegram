class CommentsController < ApplicationController
  def show
    @recipes = Recipe.all
  end

  def create
    current_user.comment(params[:comment], params[:recipe_id])
    redirect_to request.referer
  end

  def destroy
    current_user.uncomment(params[:comment_id])
    redirect_to request.referer
  end
end
