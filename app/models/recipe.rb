class Recipe < ApplicationRecord
  belongs_to :user
  attachment :image

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
  
  has_many :favorites, class_name: 'Favorite', foreign_key: 'user_id', dependent: :destroy
  # いいねしたユーザー一覧で使う
  has_many :users, through: :favorites, source: :recipe
end
