class RenameNotification < ActiveRecord::Migration[7.0]
  def change
    rename_column :notifications, :post_id, :recipe_id
  end
end
