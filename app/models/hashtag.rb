# frozen_string_literal: true

class Hashtag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :recipehashtags, class_name: 'RecipeHashtag', dependent: :destroy
  # ハッシュタグのレシピ一覧で使う
  has_many :recipes, through: :recipehashtags, source: :recipe
  has_many :hashtag_counts
end
