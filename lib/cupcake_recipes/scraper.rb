
class CupcakeRecipes::Scraper


    def self.scrape_all_recipes
        self.scrape_nk
        self.scrape_ssr
        self.scrape_sba
        CupcakeRecipes::Recipes.all
    end

    def self.scrape_nk
        doc = Nokogiri::HTML(open("https://natashaskitchen.com/category/dessert/cupcakes/"))

        doc.css("div.li-a a").each {|recipe|
            CupcakeRecipes::Recipes.create_cupcake(recipe.text.strip, recipe.attribute('href').value, "Natasha's Kitchen", CupcakeRecipes::Recipes.all)}
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

        doc.css(".rititle.rinojs.always p a").each {|recipe|
            CupcakeRecipes::Recipes.create_cupcake(recipe.text.strip, recipe.attribute('href').value, "Sugar Spun Run", CupcakeRecipes::Recipes.all)}
    end

    def self.scrape_sba
        i = 1
        while i < 5
            if i == 1
                doc = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/"))
            else
                doc = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/page/#{i}/"))
            end
            doc.css(".uabb-post-heading.uabb-blog-post-section a").each {|recipe|
                CupcakeRecipes::Recipes.create_cupcake(recipe.text.strip, recipe.attribute('href').value, "Sally's Baking Addiction", CupcakeRecipes::Recipes.all)}
            i += 1
        end
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