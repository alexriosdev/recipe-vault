require_relative './config/environment'

class RecipeVaultCLI

  def welcome_message
    # puts " "
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
    # puts " "
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

  # def delete_a_book
  #   puts "Select the id of the book that you wanna delete:"
  #   book_id = gets.chomp
  #   @book = Book.find_by(id: book_id)
  #   @book.destroy

  #   list_recipes
  # end

  def run
    welcome_message
    list_recipes
    list_users
    list_ingredients
  end

end

RecipeVaultCLI.new.run