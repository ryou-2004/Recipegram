class RecipeHashtag < ApplicationRecord
  belongs_to :recipe, class_name: "recipe"
  belongs_to :hashtag, class_name: "hashtag"
end
