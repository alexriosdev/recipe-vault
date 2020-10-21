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
                                                                                            
    
    ".colorize(:light_blue)
  end

  def exit_message
    puts "Thanks for using Recipe Vault!\nGoodbye.".colorize(:green)
    page_divider
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
    # sleep(1)
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
    all_recipes = Recipe.all.map { |recipe| recipe.name }

    all_recipes << turn_back

    puts "\nOkay #{@user.username}."
    query =  "Here is a list of all the recipes:\n".colorize(:yellow)
    recipe_name = prompt.select(query, all_recipes)

    case recipe_name
    when turn_back
      user_menu
    else
      @recipe_object = Recipe.all.find_by(name: recipe_name)
      recipe_ingredient_association
      show_recipe_details   
    end     
  end

  def show_recipe_details    
    page_divider
    puts "\nRecipe Name: " + "\n#{@recipe_object.name}".colorize(:yellow)
    puts "\nDescription: \n#{@recipe_object.description}"
    puts "\nPreparation: \n#{@recipe_object.preparation}"
    puts "\nIngredients: "
    @ingredient_object.each { |ingredient| puts "#{ingredient.name}"}

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
      # WOULD YOU LIKE TO ADD OR CREATE ONE?
      user_menu
    else
      id_array = @favorite_recipes.each.map{ |recipe| recipe.recipe_id }
      @favorite_object = []
      id_array.each{ |id| @favorite_object << Recipe.find_by(id: id) } 

      choices = @favorite_object.map { |recipe| recipe.name }
      choices << turn_back

      puts "\nVery well, #{@user.username}!"
      query = "Here is a list of your favorite recipes:".colorize(:yellow)
      recipe_name = prompt.select(query, choices)

      case recipe_name
      when turn_back
        user_menu
      else        
        @recipe_object = Recipe.all.find_by(name: recipe_name)
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
      "Delete Recipe",
      turn_back
    ])
    case user_choice
    when "Fix or Update Recipe"
      update_recipe
    when "Delete Recipe"
      delete_recipe
    else
      list_favorite_recipes
    end
  end

  # SQL METHODS

  def create_new_recipe
    page_divider
    prompt = prompt = TTY::Prompt.new()

    puts "\nAwesome! Let's get cookin'."
    new_name = prompt.ask( "What's the name of your New Recipe?".colorize(:yellow) ) 
    new_desc = prompt.ask( "Add a short description to your recipe.".colorize(:yellow) )    
    ing_name = prompt.ask( "Please list the ingridients.".colorize(:yellow) )
    new_prep = prompt.ask( "Could explain the preparation steps?".colorize(:yellow) )
    
    r = Recipe.create(
      name: new_name, 
      description: new_desc,
      preparation: new_prep,
    )
    i = Ingredient.create(name: ing_name)
    ri = RecipeIngredient.create(recipe_id: r.id, ingredient_id: i.id)
    f = Favorite.create(user_id: @user.id, recipe_id: r.id)

    page_divider
    puts "\nName: " + "\n#{new_name}".colorize(:yellow)
    puts "\nDescription: \n#{new_desc}"
    puts "\nIngredients:\n#{ing_name}"
    puts "\nPreparation: \n#{new_prep}"
    
    puts "\n...aaaaand we're done!".colorize(:yellow) + "\nThis is what your creation looks like."
    favorite_options

  end

  def add_to_favorites
    stay_tuned_message
    user_menu
  end

  def update_recipe
    stay_tuned_message
    user_menu
  end

  def delete_recipe    
    stay_tuned_message
    user_menu

    # Work in progress 
    # recipe = Recipe.find_by(name:"")
    # recipe.destroy

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

Main.new.run