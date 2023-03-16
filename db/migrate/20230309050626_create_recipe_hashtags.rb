# frozen_string_literal: true

class CreateRecipeHashtags < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_hashtags, &:timestamps
  end
end
