# i1 = Ingredient.create(name: "Eggs")
# i2 = Ingredient.create(name: "Ham")
# i3 = Ingredient.create(name: "Bacon")
# i4 = Ingredient.create(name: "Green ink")

# r1 = Recipe.create(
#   name: "Eggs and Ham", 
#   description: "Yummy yummy it fills up the tummy",
#   instructions: "Put Eggs and Ham in a pan & heat it up!",
# )

# r2 = Recipe.create(
#   name: "Green Eggs and Ham", 
#   description: "Yuck!",
#   instructions: "Mix Eggs, Ham and Ink.",
# )
  
# r3 = Recipe.create(
#   name: "Eggs and Bacon", 
#   description: "This is bad for your heart!",
#   instructions: "Put Eggs and Bacon a pan & heat it up!",
# )

# # Recipe Associations
# a1 = RecipeIngredient.create(recipe_id: r1.id, ingredient_id: i1.id)
# a2 = RecipeIngredient.create(recipe_id: r1.id, ingredient_id: i2.id)
# a3 = RecipeIngredient.create(recipe_id: r2.id, ingredient_id: i1.id)
# a4 = RecipeIngredient.create(recipe_id: r2.id, ingredient_id: i2.id)
# a5 = RecipeIngredient.create(recipe_id: r2.id, ingredient_id: i4.id)
# a6 = RecipeIngredient.create(recipe_id: r3.id, ingredient_id: i1.id)
# a7 = RecipeIngredient.create(recipe_id: r3.id, ingredient_id: i3.id)    
  
# u1 = User.create(username: "Jon Snow", password: "123")
# u2 = User.create(username: "Rob Stark", password: "123")

# # User Associations
# f1 = Favorite.create(user_id: u1.id, recipe_id: r1.id)
# f2 = Favorite.create(user_id: u1.id, recipe_id: r2.id)
# f3 = Favorite.create(user_id: u2.id, recipe_id: r3.id)