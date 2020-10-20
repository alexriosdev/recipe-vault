require_relative './config/environment'

class RecipeVaultCLI
  
  def run
    welcome_message
    list_recipes
    list_users
    list_ingredients
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
                                                                                            
    
    "
  end

  def list_recipes
    puts "=========== List of Recipes ========="

    Recipe.all.each do |recipe|
        puts "#{recipe.id}: #{recipe.name}"
    end

    puts "===========      End        ========="
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

  # EARCH TESTING
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

RecipeVaultCLI.new.run