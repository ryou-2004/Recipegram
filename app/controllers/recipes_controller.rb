# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @recipes = Recipe.all
    date1 = Date.new(2023, 1, 1)
    date2 = Date.new(2023, 4, 1)
    @ranking = HashtagCount.generate_ranking(5, date1, date2)
    @ranking.each do |hashtag_count|
      logger.debug("#{hashtag_count.hashtag.name}: #{hashtag_count.count}")
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    hashtags = params[:hashtags].split(' ')
    hashtags.each do |tag|
      hashtag = Hashtag.find_or_create_by(name: tag)
      @recipe.hashtags << hashtag
      count = HashtagCount.find_or_initialize_by(hashtag: hashtag, date: Date.today)
      count.count ||= 0
      count.count += 1
      count.save
    end

    if @recipe.save
      redirect_to recipe_path(@recipe), notice: '投稿に成功しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user != current_user
      redirect_to recipes_path, alert: '不正なアクセスです。'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: '更新に成功しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipe_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :body, :image)
  end
end
