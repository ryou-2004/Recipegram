# frozen_string_literal: true

class RelationshipsController < ApplicationController
  # フォローするとき
  def create
    relationship = current_user.follow(params[:user_id])
    relationship.followed.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @user = user
    @users = user.followings
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @user = user
    @users = user.followers
  end
end
