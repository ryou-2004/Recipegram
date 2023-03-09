class Recipe < ApplicationRecord
  belongs_to :user
  attachment :image

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true

  has_many :favorites, class_name: 'Favorite', dependent: :destroy
  # いいねしたユーザー一覧で使う
  has_many :favousers, through: :favorites, source: :user

  has_many :recipehashtags, class_name: 'RecipeHashtag', dependent: :destroy
  # ハッシュタグ一覧で使う
  has_many :hashtags, through: :recipehashtags, source: :hashtag
end
