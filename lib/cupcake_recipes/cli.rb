# Controller

class CupcakeRecipes::CLI

    def call
        welcome
        get_recipes
        print_recipe
        goodbye
    end

    def welcome
        puts "Welcome to Best Cupcake Recipes!"
    end

    def goodbye
        puts "Thanks for using Best Cupcake Recipes. I bet you made something delicious!"
    end

    def get_recipes
        puts "What flavor cupcake would you like to bake?", "(Enter 1-3 or 'exit' for 1. Vanilla, 2. Chocolate, and 3. I'm feeling adventurous!)"
        input_flavor = gets.strip
        @recipes = CupcakeRecipes::Recipes.scrape_recipes
        if input_flavor == "1" || input_flavor == "2" || input_flavor == "3"
            sorted_recipes = @recipes[input_flavor.to_i-1].sort {|x,y| x[:name] <=> y[:name]}
            sorted_recipes.each.with_index(1) {|recipe,i|
                puts "#{i}. #{recipe[:name]} - #{recipe[:source]}"
            }
        elsif input_flavor!="exit"
            puts "That was not a valid input. Please enter a number from 1-3 or type 'exit'."
            get_recipes
        end
    end

    def print_recipe
        input_recipe = nil
        while input_recipe != 'exit'
            puts "Enter the number of the recipe you'd like to see or type 'exit':"
            input_recipe = gets.strip.downcase
            if input_recipe != 'exit'
                puts "recipe here"
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