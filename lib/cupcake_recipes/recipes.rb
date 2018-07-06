require 'open-uri'

class CupcakeRecipes::Recipes
    # nk = Natasha's Kitchen
    # ssr = Sugar Spun Run
    # sba = Sally's Baking Addiction

    attr_accessor :name, :type, :url, :source, :recipe

    def initialize(attributes)
        attributes.each {|k,v| self.send(("#{k}="),v)}
    end

    def self.scrape_all_recipes
        recipes = [self.scrape_nk, self.scrape_ssr, self.scrape_sba].flatten(1)
    end

    def self.scrape_nk
        doc = Nokogiri::HTML(open("https://natashaskitchen.com/category/dessert/cupcakes/"))
        recipes_nk = []

        doc.css("div.li-a a").each {|recipe|
            recipe_name = recipe.text.strip
            recipe_url = recipe.attribute('href').value
            if recipe_name.include?("Cupcake") && !recipes_nk.any?{|recipe| recipe.name == recipe_name}
                new_cupcake = CupcakeRecipes::Recipes.new({name: recipe_name, url: recipe_url, source: "Natasha's Kitchen"})
                if recipe_name.include?("Vanilla Cupcake")
                        new_cupcake.type = "Vanilla"
                elsif recipe_name.include?("Chocolate Cupcake")
                        new_cupcake.type = "Chocolate"
                else
                        new_cupcake.type = "Lucky"
                end
                new_cupcake.recipe = scrape_nk_ssr_recipe(recipe_url)
                recipes_nk << new_cupcake
            end
        }
        recipes_nk
    end

    def self.scrape_nk_ssr_recipe(recipe_url)
        doc = Nokogiri::HTML(open(recipe_url))
        ingredients, directions = [],[]

        doc.css(".wprm-recipe-ingredient").each {|ingredient|
            ingredients << "#{ingredient.css(".wprm-recipe-ingredient-amount").inner_text} #{ingredient.css(".wprm-recipe-ingredient-unit").inner_text} #{ingredient.css(".wprm-recipe-ingredient-name").inner_text}"
        }
        doc.css(".wprm-recipe-instruction-text").each {|direction|
            directions << direction.inner_text
        }
        recipe = {ingredients: ingredients, directions: directions}
    end

    def self.scrape_ssr
        doc = Nokogiri::HTML(open("https://sugarspunrun.com/recipe-index/"))
        recipes_ssr = []

        doc.css(".rititle.rinojs.always p a").each {|recipe|
        recipe_name = recipe.text.strip
        recipe_url = recipe.attribute('href').value
        if recipe_name.include?("Cupcake") && !recipes_ssr.any?{|recipe| recipe.name == recipe_name}
            new_cupcake = CupcakeRecipes::Recipes.new({name: recipe_name, url: recipe_url, source: "Sugar Spun Run"})
            if recipe_name.include?("Vanilla Cupcake")
                    new_cupcake.type = "Vanilla"
            elsif recipe_name.include?("Chocolate Cupcake")
                    new_cupcake.type = "Chocolate"
            else
                    new_cupcake.type = "Lucky"
            end
            new_cupcake.recipe = scrape_nk_ssr_recipe(recipe_url)
            recipes_ssr << new_cupcake
        end
        }
        recipes_ssr
    end

    def self.scrape_sba
        recipes_sba = []

        i = 1
        while i < 5
            if i == 1
                doc = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/"))
            else
                doc = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/page/#{i}/"))
            end
            doc.css(".uabb-post-heading.uabb-blog-post-section a").each {|recipe|
            recipe_name = recipe.text.strip
            recipe_url = recipe.attribute('href').value
            if recipe_name.include?("Cupcake") && !recipes_sba.any?{|recipe| recipe.name == recipe_name}
                new_cupcake = CupcakeRecipes::Recipes.new({name: recipe_name, url: recipe_url, source: "Sally's Baking Addiction"})
                if recipe_name.include?("Vanilla Cupcake")
                        new_cupcake.type = "Vanilla"
                elsif recipe_name.include?("Chocolate Cupcake")
                        new_cupcake.type = "Chocolate"
                else
                        new_cupcake.type = "Lucky"
                end
                new_cupcake.recipe = scrape_sba_recipe(recipe_url)
                recipes_sba << new_cupcake
            end
            }
            i += 1
        end
        recipes_sba
    end

    def self.scrape_sba_recipe(recipe_url)
        doc = Nokogiri::HTML(open(recipe_url))
        ingredients, directions = [],[]

        doc.css(".ingredient").each {|ingredient|
            ingredients << ingredient.inner_text}
        doc.css(".instructions ol li").each {|direction|
            directions << direction.inner_text}
        recipe = {ingredients: ingredients, directions: directions}
    end

end