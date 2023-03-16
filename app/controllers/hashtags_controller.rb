class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(name: params[:hashtag])
    if @hashtag
      @hashtag_name = @hashtag.name
      @recipes = Recipe.joins(:recipehashtags).where(recipehashtags: { hashtag_id: @hashtag.id })
    else
      @hashtag_name = ''
    end
  end
  def search
    logger.debug("params[:searchtag]#{params[:searchtag]}")
    redirect_to action: "show", hashtag: params[:searchtag]
  end
end
