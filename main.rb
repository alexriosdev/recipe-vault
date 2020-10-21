require_relative './config/environment'

class Main
  
  def run
    # binding.pry
    welcome_message
    start_menu
  end

  # WRITE LOGIG METHODS BELOW
  private

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

  def page_divider
    puts "_____________________________________________________".colorize(:green)
  end

  # INTERFACE METHODS

  def start_menu
    prompt = TTY::Prompt.new()
    welcome =  "\nWelcome to Recipe Vault!".colorize(:light_blue)
    user_choice = prompt.select(welcome, [
        "Login",
        "Search Recipe", 
        "Exit!"
    ])
    case user_choice
    when "Login"
      login_prompt
    when "Search Recipe"
      search_recipe
    else
      puts "BYE BYE"
    end
  end

  def login_prompt
    page_divider
    prompt = TTY::Prompt.new()
    response = prompt.ask("\nPlease enter a username: ").downcase
    @user = User.find_or_create_by(username: response)
    sleep(1)
    user_menu
  end

  def user_menu
    page_divider
    prompt = TTY::Prompt.new()
    puts "\nHello there, #{@user.username}!"
    query = "What would you like to do?".colorize(:yellow)
    user_choice = prompt.select(query, [
        "Display All Recipes",
        "Display Favorite Recipes",
        "Create Recipe",
        "Search Recipe", 
        "Exit!"
    ])
    case user_choice
    when "Display All Recipes"
      list_all_recipes
    when "Display Favorite Recipes"
      list_favorite_recipes
    when "Create New Recipe"
      create_new_recipe
    when "Search Recipe"
      search_recipe
    else
      puts "BYE BYE"
    end
  end

  def list_all_recipes
    page_divider

    prompt = TTY::Prompt.new() 
    all_recipes = Recipe.all.map { |recipe| recipe.name }

    puts "\nOkay #{@user.username}."
    query =  "Here is a list of all the recipes:\n".colorize(:yellow)
    recipe_name = prompt.select(query, all_recipes)
    @recipe_object = Recipe.all.find_by(name: recipe_name)

    # add method to go back in the menu?

    recipe_ingredient_association
    show_recipe_details    
  end

  def show_recipe_details
    page_divider
    puts "\n#{@recipe_object.name} Recipe".colorize(:yellow)
    puts "\nDescription: \n#{@recipe_object.description}"
    puts "\nPreparation: \n#{@recipe_object.preparation}"
    puts "\nIngredients: "
    @ingredient_object.each { |ingredient| puts "#{ingredient.name}"}

    # puts "\nIngredients: \n#{@ingredient_object.name}"

    # SAVE RECIPE TO FAVORITES METHOD
    user_menu
  end

  def recipe_ingredient_association
    # this method only finds ONE object
    # ri = RecipeIngredient.find_by(recipe_id: @recipe_object.id)
    
    # returns array of objects
    ri_objects = RecipeIngredient.where(recipe_id: @recipe_object.id)

    # store ingredient ids in array
    i_array = ri_objects.each.map{ |ingredient| ingredient.ingredient_id }
    
    @ingredient_object = []
    i_array.each{ |i| @ingredient_object << Ingredient.find_by(id: i) }
    @ingredient_object
    
    # binding.pry
    
    
  end

  def list_favorite_recipes
    puts "\nSTAY TUNED. FEATURE COMMING SOON.".colorize(:red)
    user_menu
  end

  def create_new_recipe
    puts "\nSTAY TUNED. FEATURE COMMING SOON.".colorize(:red)
    user_menu
  end

  def search_recipe
    puts "\nSTAY TUNED. FEATURE COMMING SOON.".colorize(:red)
    start_menu
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