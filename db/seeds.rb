# Add seed data here. Seed your database with `rake db:seed`
Favorite.destroy_all
RecipeIngredient.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
User.destroy_all

# puts File.exist?("./db/db-recipes.json")

file = File.read("./db/db-recipes.json")
data = JSON.parse(file)

even_num = (1..30).select(&:even?).each
factor = even_num.size

factor.times do |n|
  begin
    r = Recipe.create(
      name: data[n.to_s]["name"].downcase,
      description: data[n.to_s]["comments"],
      preparation: data[n.to_s]["instructions"]
    )
    data[n.to_s]["ingredients"].each do |ingredient|
      i = Ingredient.create(name: ingredient.downcase)
      RecipeIngredient.create(recipe_id: r.id, ingredient_id: i.id)
    end
  rescue NoMethodError; TypeError
    next
  end
end

binding.pry