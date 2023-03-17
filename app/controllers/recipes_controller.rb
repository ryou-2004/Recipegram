# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @recipes = Recipe.all
    @day_ranking = HashtagCount.generate_ranking(1, Date.today, Date.today)
    @week_ranking = HashtagCount.generate_ranking(1, Date.today.ago(7.days), Date.today)
    @month_ranking = HashtagCount.generate_ranking(1, Date.today.ago(30.days), Date.today)
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
