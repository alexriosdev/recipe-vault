class Recipe < ActiveRecord::Base
  has_many :favorites
  has_many :users, through: :favorites

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
end