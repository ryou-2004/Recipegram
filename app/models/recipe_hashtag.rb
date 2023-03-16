class RecipeHashtag < ApplicationRecord
  belongs_to :recipe, class_name: 'Recipe'
  belongs_to :hashtag, class_name: 'Hashtag'
end
