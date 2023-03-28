class NotificationsController < ApplicationController
  def index
    if current_user != nil
      @notifications = current_user.passive_notifications
      @notifications.where(checked: false).each do |notification|
        notification.update_attribute(:checked, true)
      end
    end
  end
end
