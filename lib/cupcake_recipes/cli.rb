# Controller

class CupcakeRecipes::CLI

    def call
        welcome
        scrape_recipes
        get_recipes
        goodbye
    end

    def welcome
        puts "Welcome to Best Cupcake Recipes!", "Loading recipes..."
    end

    def goodbye
        puts "Thanks for using Best Cupcake Recipes. I bet you made something delicious!"
    end

    def scrape_recipes
        @recipes = CupcakeRecipes::Recipes.scrape_all_recipes
    end

    def get_recipes
        puts "What flavor cupcake would you like to bake?", "(Enter 1-3 or 'exit' for 1. Vanilla, 2. Chocolate, and 3. I'm feeling adventurous!)"
        input_flavor = gets.strip
        if input_flavor == "1" || input_flavor == "2" || input_flavor == "3"
            @sorted_recipes = @recipes[input_flavor.to_i-1].sort {|x,y| x[:name] <=> y[:name]}
            @sorted_recipes.each.with_index(1) {|recipe,i|
                puts "#{i}. #{recipe[:name]} - #{recipe[:source]}"
            }
            print_recipe
        elsif input_flavor!="exit"
            puts "That was not a valid input. Please enter a number from 1-3 or type 'exit'."
            get_recipes
            print_recipe
        end
    end

    def print_recipe
        input_recipe = nil
        while input_recipe != 'exit'
            puts "Enter the number of the recipe you'd like to see or type 'exit':"
            input_recipe = gets.strip.downcase
            # Invalid input cases are:
            # 1. Is not a postive integer and not "exit"
            # 2. Is a positive integer but not a number on the given list
            if (input_recipe =~ /\D/ && input_recipe != 'exit') || (input_recipe !~ /\D/ && (input_recipe.to_i > @sorted_recipes.length || input_recipe.to_i == 0))
                puts "That was not a valid input."
                print_recipe
            elsif input_recipe != 'exit'
                puts @sorted_recipes[input_recipe.to_i-1][:name]
                puts "Ingredients:"
                i = 0
                ingredients = @sorted_recipes[input_recipe.to_i-1][:recipe][:ingredients]
                while i < ingredients.length
                    puts "#{i+1}. #{ingredients[i]}"
                    i+=1
                end
                puts "Directions:"
                i = 0
                directions = @sorted_recipes[input_recipe.to_i-1][:recipe][:directions]
                while i < directions.length
                    puts "#{i+1}. #{directions[i]}"
                    i+=1
                end
                puts "Would you like to see another recipe? (y/n):"
                continue = gets.strip.downcase
                if continue == 'y'
                    get_recipes
                elsif continue == 'n'
                    break
                end
            end
        end
    end

end