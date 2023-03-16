class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(name: params[:hashtag])
    if @hashtag
      @hashtag_name = @hashtag.name
      @recipes = Recipe.joins(:recipehashtags).where(recipehashtags: { hashtag_id: @hashtag.id })
    else
      @hashtag_name = params[:hashtag]
    end
  end

  def search
    redirect_to action: 'show', hashtag: params[:searchtag]
  end
end
