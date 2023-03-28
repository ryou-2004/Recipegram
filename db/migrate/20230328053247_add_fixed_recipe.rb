class AddFixedRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :fixed_recipe_id, :integer
  end
end
