class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find(params[:id])
    @recipes = Recipe.joins(:recipehashtags).where(recipehashtags: { hashtag_id: @hashtag.id })
  end
end
