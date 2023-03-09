class Hashtag < ApplicationRecord
  has_many :recipes, class_name: 'Recipe', dependent: :destroy
  has_many :recipehashtags, through: :recipe_hashtags
end
