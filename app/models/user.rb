# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :recipes, dependent: :destroy

  validates :username, presence: true

  belongs_to :fixed_recipe, class_name: 'Recipe', optional: true, foreign_key: 'fixed_recipe_id'

  has_many :favorites, class_name: 'Favorite', foreign_key: 'user_id', dependent: :destroy
  # いいねしたレシピ一覧画面で使う
  has_many :favorecipes, through: :favorites, source: :recipe

  has_many :comments, class_name: 'Comment', foreign_key: 'user_id', dependent: :destroy
  # コメントしたレシピ一覧画面で使う
  has_many :commrecipes, through: :comments, source: :recipe

  # フォローをした、されたの関係
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  # フォローしたときの処理
  def follow(user_id)
    return relationships.create(followed_id: user_id)
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
    return favorites.create(recipe_id: recipe_id)
  end

  # いいねを外すときの処理
  def unfavorite(recipe_id)
    favorites.find_by(recipe_id: recipe_id).destroy
  end

  def favoriting?(recipe)
    favorecipes.include?(recipe)
  end

  def comment(comment, recipe_id)
    return comments.create(body: comment, recipe_id: recipe_id)
  end

  def uncomment(comment_id)

  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
