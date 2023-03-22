class CommentsController < ApplicationController
  def show
    @recipes = Recipe.all
  end

  def create
    comment = current_user.comment(params[:comment], params[:recipe_id])
    comment.create_notification_comment!(current_user, comment.id)
    redirect_to request.referer
  end

  def destroy
    current_user.uncomment(params[:comment_id])
    redirect_to request.referer
  end
end
