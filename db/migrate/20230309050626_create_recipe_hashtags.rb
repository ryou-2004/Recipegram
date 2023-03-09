class CreateRecipeHashtags < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_hashtags do |t|

      t.timestamps
    end
  end
end
