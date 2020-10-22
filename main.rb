require_relative './config/environment'

class Main
  
  def run
    # binding.pry

    welcome_message
    start_menu
  end

  # WRITE LOGIG METHODS BELOW
  private
  
  # INTERFACE MESSAGE METHODS

  def test_prompt
    prompt =  TTY::Prompt.new()
    response = prompt.ask("Hello there").titleize
    puts response
  end

  def welcome_message
    puts "

    ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗    ████████╗ ██████╗     
    ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝    ╚══██╔══╝██╔═══██╗    
    ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗         ██║   ██║   ██║    
    ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝         ██║   ██║   ██║    
    ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗       ██║   ╚██████╔╝    
     ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝       ╚═╝    ╚═════╝     
    ██████╗ ███████╗ ██████╗██╗██████╗ ███████╗    ██╗   ██╗ █████╗ ██╗   ██╗██╗  ████████╗ 
    ██╔══██╗██╔════╝██╔════╝██║██╔══██╗██╔════╝    ██║   ██║██╔══██╗██║   ██║██║  ╚══██╔══╝ 
    ██████╔╝█████╗  ██║     ██║██████╔╝█████╗      ██║   ██║███████║██║   ██║██║     ██║    
    ██╔══██╗██╔══╝  ██║     ██║██╔═══╝ ██╔══╝      ╚██╗ ██╔╝██╔══██║██║   ██║██║     ██║    
    ██║  ██║███████╗╚██████╗██║██║     ███████╗     ╚████╔╝ ██║  ██║╚██████╔╝███████╗██║    
    ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝╚═╝     ╚══════╝      ╚═══╝  ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝                                                                                         
    ".colorize(:light_green)
    app_description
  end

  def exit_message
    puts "Thanks for using Recipe Vault!\nGoodbye.".colorize(:green)
    page_divider
  end

  def app_description
    puts "
    Recipe Vault is a CLI platform that allows users to create, 
    save and share recipes with other users.
    Recipe Vault also serves as a recipe search-engine,
    giving users the option to search for a recipe based on the recipe name or their ingredients."
  end

  def page_divider
    sleep(1)
    puts "_____________________________________________________".colorize(:green)
  end

  def turn_back
    "Turn Back.".colorize(:red)
  end

  def stay_tuned_message
    puts "\nSTAY TUNED. FEATURE COMMING SOON.".colorize(:red)
  end

  def logout_prompt
    puts "Thanks for using Recipe Vault!\nGoodbye, #{@user.username}.".colorize(:green)
    page_divider
    start_menu
  end

  # INTERFACE NAVIGATION METHODS
  
  def start_menu
    @user_session = false
    prompt = TTY::Prompt.new()
    welcome =  "\nWelcome to Recipe Vault!".colorize(:light_blue)
    user_choice = prompt.select(welcome, [
      "Login",
      "Search Recipe", 
      "Exit.".colorize(:red)
    ])
    case user_choice
    when "Login"
      login_prompt
    when "Search Recipe"
      search_recipe
    else
      exit_message
    end
  end

  def login_prompt
    page_divider
    prompt = TTY::Prompt.new()
    response = prompt.ask("\nPlease enter a username: ").downcase
    @user = User.find_or_create_by(username: response)
    user_menu
  end

  def user_menu
    @user_session = true
    page_divider
    prompt = TTY::Prompt.new()
    puts "\nHello there, #{@user.username}!"
    query = "What would you like to do?".colorize(:yellow)
    user_choice = prompt.select(query, [
        "Display All Recipes",
        "Display Favorite Recipes",
        "Create Recipe",
        "Search Recipe", 
        "Logout.".colorize(:red)
    ])
    case user_choice
    when "Display All Recipes"
      list_all_recipes
    when "Display Favorite Recipes"
      list_favorite_recipes
    when "Create Recipe"
      create_new_recipe
    when "Search Recipe"
      search_recipe
    else
      logout_prompt
    end
  end

  def list_all_recipes
    @favorite_session = false
    page_divider

    prompt = TTY::Prompt.new() 
    all_recipes = Recipe.all.map { |recipe| recipe.name.titleize }

    all_recipes << turn_back

    puts "\nOkay #{@user.username}."
    query =  "Here is a list of all the recipes:\n".colorize(:yellow)
    recipe_name = prompt.select(query, all_recipes)

    case recipe_name
    when turn_back
      user_menu
    else
      @recipe_object = Recipe.all.find_by(name: recipe_name.downcase)
      recipe_ingredient_association
      show_recipe_details   
    end     
  end

  def show_recipe_details    
    page_divider
    puts "\nRecipe Name: " + "\n#{@recipe_object.name.titleize}".colorize(:yellow)
    puts "\nDescription: \n#{@recipe_object.description}"
    puts "\nPreparation: \n#{@recipe_object.preparation}"
    puts "\nIngredients: "
    @ingredient_object.each { |ingredient| puts "#{ingredient.name.titleize}"}

    favorite_options if @favorite_session
    detail_options if !@favorite_session
  end

  def detail_options
    prompt = prompt = TTY::Prompt.new()
    query =  "What would you like to do with this recipe?\n".colorize(:yellow)
    user_choice = prompt.select(query, [
      "Add to Favorites",
      turn_back
    ])
    case user_choice
    when "Add to Favorites"
      add_to_favorites
    else
      list_all_recipes
    end
  end

  def recipe_ingredient_association
    # returns array of objects
    ri_objects = RecipeIngredient.where(recipe_id: @recipe_object.id)

    # store ingredient ids in array
    id_array = ri_objects.each.map{ |ingredient| ingredient.ingredient_id }
    
    @ingredient_object = []
    id_array.each{ |id| @ingredient_object << Ingredient.find_by(id: id) }
    @ingredient_object    
  end
  
  def list_favorite_recipes
    @favorite_session = true
    page_divider

    prompt = TTY::Prompt.new()

    @favorite_recipes = Favorite.all.where(user_id: @user.id)

    if @favorite_recipes.empty?
      puts "Sorry #{@user.username}. it seems that you have no Favorite Recipes."
      user_menu
    else
      id_array = @favorite_recipes.each.map{ |recipe| recipe.recipe_id }
      @favorite_object = []
      id_array.each{ |id| @favorite_object << Recipe.find_by(id: id) } 

      choices = @favorite_object.map { |recipe| recipe.name.titleize }
      choices << turn_back

      puts "\nVery well, #{@user.username}!"
      query = "Here is a list of your favorite recipes:".colorize(:yellow)
      recipe_name = prompt.select(query, choices)

      case recipe_name
      when turn_back
        user_menu
      else        
        @recipe_object = Recipe.all.find_by(name: recipe_name.downcase)
        recipe_ingredient_association
        show_recipe_details   
      end  
    end    
  end
  
  def favorite_options
    prompt = prompt = TTY::Prompt.new()
    query =  "What would you like to do with this recipe?\n".colorize(:yellow)
    user_choice = prompt.select(query, [
      "Fix or Update Recipe",
      "Remove From Favorites",
      turn_back
    ])
    case user_choice
    when "Fix or Update Recipe"
      update_recipe
    when "Remove From Favorites"
      remove_from_favorites
    else
      list_favorite_recipes
    end
  end

  # SQL METHODS

  # DEVELOP NEW METHOD FOR THE INGREDIENT RESPONSE
  def create_new_ingredients    
    prompt = TTY::Prompt.new()
    ingredient_collection = []
    n = prompt.ask("How many ingredients does this recipe need?".colorize(:yellow), default: 2, convert: :integer)
    n.times do |count|
      name = prompt.ask("Please insert ingredient ##{count + 1}:", default: "Tomato").downcase
      # CREATE THE INGREDIENTS AND SAVE
      new_ingredient = Ingredient.find_or_create_by(name: name)
      # CREATE ASSOCIATION
      RecipeIngredient.create(recipe_id: @recipe_create.id, ingredient_id: new_ingredient.id)
      count += 1
    end
  end

  def create_new_recipe
    @favorite_session = true

    page_divider
    prompt = TTY::Prompt.new()
    
    puts "\nAwesome! Let's get cookin'."
    new_name = prompt.ask( "What's the name of your New Recipe?".colorize(:yellow) ).downcase
    @recipe_create = Recipe.create(name: new_name)

    new_desc = prompt.ask( "Add a short Description to your recipe.".colorize(:yellow) )
    @recipe_create.update(description: new_desc)

    create_new_ingredients  

    new_prep = prompt.ask( "Could you explain the Preparation steps?".colorize(:yellow) )
    @recipe_create.update(preparation: new_prep)

    Favorite.create(user_id: @user.id, recipe_id: @recipe_create.id)

    @recipe_object = Recipe.all.find_by(id: @recipe_create.id)
    puts "\n...aaaaand we're done!".colorize(:green)
    puts "\nThis is what your creation looks like.".colorize(:yellow)
    recipe_ingredient_association
    show_recipe_details 
  end

  def add_to_favorites
    page_divider
    Favorite.find_or_create_by(user_id: @user.id, recipe_id:@recipe_object.id)
    puts "Succesfully added #{@recipe_object.name} to your favorites!".colorize(:green)
    list_all_recipes
  end

  def update_ingredients    
    prompt = TTY::Prompt.new()
    recipe_ingredient_association
    choices = @ingredient_object.map { |i| i.name.titleize }
    choices << "Add New Ingredients.".colorize(:green)
    choices << turn_back

    user_choice = prompt.select( "Select the ingredient that you'd like to change:".colorize(:yellow), choices)

    case user_choice
    when turn_back
      show_recipe_details
    when "Add New Ingredients.".colorize(:green)
      name = prompt.ask("Please insert new ingredient:", default: "Tomato").downcase
      # CREATE THE INGREDIENTS AND SAVE
      new_ingredient = Ingredient.find_or_create_by(name: name)
      # CREATE ASSOCIATION
      RecipeIngredient.create(recipe_id: @recipe_object.id, ingredient_id: new_ingredient.id)
      puts "Succesfully added #{name.titleize} to #{@recipe_object.name.titleize}".colorize(:green)
      recipe_ingredient_association
      show_recipe_details
    else
      i_id = @ingredient_object.map { |i| i.id if i.name == user_choice.downcase }.uniq[0]
      new_name = prompt.ask( "Update Ingredient:".colorize(:yellow), value: user_choice).downcase
      Ingredient.find_by(id: i_id).update(name: new_name)
      puts "Succesfully updated #{user_choice} to #{new_name.titleize}".colorize(:green)
      recipe_ingredient_association
      show_recipe_details
    end
  end

  def update_recipe
    page_divider
    prompt = TTY::Prompt.new()
    query = "What would you like to change?".colorize(:yellow)
    user_choice = prompt.select(query, [
      "Recipe Name",
      "Description",
      "Preparation",
      "Ingredients",
      turn_back
    ])    
    case user_choice
    when "Recipe Name"
      new_name = prompt.ask( "Update Recipe Name:".colorize(:yellow), value: @recipe_object.name ).downcase
      puts "Succesfully updated #{@recipe_object.name.titleize} to #{new_name.titleize}".colorize(:green)
      @recipe_object.update(name: new_name)      
      show_recipe_details
    when "Description"
      new_desc = prompt.ask( "Update Description:".colorize(:yellow), value: @recipe_object.description )
      puts "Succesfully updated #{@recipe_object.description} to #{new_desc}".colorize(:green)
      @recipe_object.update(description: new_desc) 
      show_recipe_details
    when "Preparation"
      new_prep = prompt.ask( "Update Preparation:".colorize(:yellow), value: @recipe_object.preparation )
      puts "Succesfully updated #{@recipe_object.preparation} to #{new_prep}".colorize(:green)
      @recipe_object.update(preparation: new_prep) 
      show_recipe_details
    when "Ingredients"
      update_ingredients
    else
      show_recipe_details      
    end
  end  

  def remove_from_favorites
    # DELETES RECIPE ASSOCIATION NOT THE RECIPE ITSELF
    prompt = TTY::Prompt.new()
    query = "Are you sure?".colorize(:red)
    user_choice = prompt.select(query, [
      "No.",
      "Yes."
    ])
    case user_choice
    when "Yes."
      favorite_object = Favorite.find_by(user_id: @user.id, recipe_id: @recipe_object.id)
      favorite_object.destroy
      puts "Succesfully removed #{@recipe_object.name} to your favorites!".colorize(:green)
      list_favorite_recipes
    else
      show_recipe_details
    end
  end  

  def search_recipe
    stay_tuned_message
    if @user_session
      user_menu
    else
      page_divider
      start_menu
    end
  end

  def list_users
    puts "=========== List of Users ========="

    User.all.each do |user|
        puts "#{user.id}: #{user.username}"
    end

    puts "===========      End        ========="
  end

  def list_ingredients
    puts "=========== List of Ingredients ========="

    Ingredient.all.each do |ingredient|
        puts "#{ingredient.id}: #{ingredient.name}"
    end

    puts "===========      End        ========="
  end

  # SEARCH TESTING
  def search_by_id
    puts "Input the id of the recipe you want to search: "
    recipe_id = gets.chomp
    result = Recipe.find_by(id: recipe_id)
    puts result.inspect.split(",")
  end

  def search_by_name
    puts "Input the name of the recipe you want to search: "
    recipe_name = gets.chomp
    result = Recipe.find_by(name: recipe_name)
    puts result.inspect.split(",")
  end

end

class String
  def titleize
    self.split(/ |\_/).map(&:capitalize).join(" ")
  end
end

Main.new.run