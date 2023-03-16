# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :recipe, class_name: 'Recipe'
end
