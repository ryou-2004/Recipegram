# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :recipe, class_name: 'Recipe'
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and recipe_id = ? and action = ? ", current_user.id, user.id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        recipe_id: recipe.id,
        visited_id: recipe.user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
