class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :recipes, dependent: :destroy

  validates :username, presence: true

  has_many :favorites, class_name: 'Favorite', foreign_key: 'user_id', dependent: :destroy
  # いいねしたレシピ一覧画面で使う
  has_many :favorecipes, through: :favorites, source: :recipe

  # フォローをした、されたの関係
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # フォローしたときの処理
  def follow(user_id)
    t = relationships.create(followed_id: user_id)
  end

  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  # いいねをしたときの処理
  def favorite(recipe_id)
    favorites.create(recipe_id: recipe_id)
  end

  # いいねを外すときの処理
  def unfavorite(recipe_id)
    favorites.find_by(recipe_id: recipe_id).destroy
  end

  def favoriting?(recipe)
    favorecipes.include?(recipe)
  end
end
