# Add seed data here. Seed your database with `rake db:seed`
Favorite.destroy_all
RecipeIngredient.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
User.destroy_all

10.times do
  Ingredient.create( name: Faker::Food.ingredient )
end

10.times do
  Recipe.create(
    name: Faker::Food.dish, 
    description: Faker::Food.description,
    preparation: Faker::Lorem.paragraph(sentence_count: 2),
  )
end

10.times do
  RecipeIngredient.create(
    recipe_id: rand(1..10),
    ingredient_id: rand(1..10)
  )
end

10.times do
  User.create(
    username: Faker::Name.unique.first_name.downcase,
    password: Faker::IDNumber.valid
  )
end

10.times do
  Favorite.create(
    user_id: rand(1..10),
    recipe_id: rand(1..10)
  )
end

binding.pry