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
        puts "What flavor cupcake would you like to bake?", "(Enter 1-3 for 1. Vanilla, 2. Chocolate, and 3. I'm feeling adventurous!)"
        input_flavor = gets.strip.to_i
        #scrap websites to get recipes
        puts <<-DOC.gsub /^\s*/, ''
            1. Perfect Vanilla Cupcake Recipe - Natasha's Kitchen
            2. Easy Vanilla Cupcakes - Sugar Spun Run
            3. Perfect Vanilla Cupcakes with Caramel Flavored Icing - Sugar Spun Run
            4. Simply Perfect Vanilla Cupcakes - Sally's Baking Addiction
            5. Very Vanilla Cupcakes - Sally's Baking Addiction
            6. Vanilla Cupcakes for Two - Sally's Baking Addiction
        DOC
    end

    def print_recipe
        continue = 'y'
        while continue == 'y'
            puts "Enter the number of the recipe you'd like to see:"
            input_recipe = gets.strip.downcase
            puts "recipe here"
            puts "Would you like to see another recipe? (y/n):"
            continue = gets.strip.downcase
        end
    end

end