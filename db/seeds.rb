# Add seed data here. Seed your database with `rake db:seed`
Ingridient.destroy_all
Recipe.destroy_all
User.destroy_all

i1 = Ingridient.create(name: "Eggs")
i2 = Ingridient.create(name: "Ham")
i3 = Ingridient.create(name: "Bacon")

r1 = Recipe.create(
  name: "Green Eggs and Ham", 
  description: "Yummy yummy it fills up the tummy",
  instructions: "Put Eggs and Ham in a pan & heat it up!",
  ingridients: i1.id, i2.id 
  )

r2 = Recipe.create(
  name: "Eggs and Bacon", 
  description: "This is bad for your heart!",
  instructions: "Put Eggs and Bacon a pan & heat it up!",
  ingridients: i1.id, i3.id 
  )

u1 = User.create(username: "Jon Snow", recipes: r1.id)
u2 = User.create(username: "Rob Stark", recipes: r2.id)
