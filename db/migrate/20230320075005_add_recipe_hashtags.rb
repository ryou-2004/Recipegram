class AddRecipeHashtags < ActiveRecord::Migration[7.0]
  def change
    add_column :recipe_hashtags, :hashtag_id, :integer
    add_column :recipe_hashtags, :recipe_id, :integer
    add_column :hashtags, :hashtag_id, :integer
  end
end
