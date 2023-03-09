class Hashtag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :recipehashtags, class_name: 'RecipeHashtag', dependent: :destroy
  # ハッシュタグのレシピ一覧で使う
  has_many :resipes, through: :recipehashtags, source: :recipe
end
