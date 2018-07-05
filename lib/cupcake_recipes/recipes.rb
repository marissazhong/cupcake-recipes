require 'open-uri'

class CupcakeRecipes::Recipes
    # nk = Natasha's Kitchen
    # ssr = Sugar Spun Run
    # sba = Sally's Baking Addiction

    attr_accessor :name, :type, :url, :source

    def self.scrape_recipes
        recipes = []

        recipes << self.scrape_nk
        recipes << self.scrape_ssr
        recipes << self.scrape_sba

        recipes
    end

    def self.scrape_nk
        doc = Nokogiri::HTML(open("https://natashaskitchen.com/category/dessert/cupcakes/"))
        recipes_nk = []

        doc.css("div.li-a a").each {|recipe| 
            recipe_name = recipe.text
            recipe_url = recipe.href
            if recipe_name.include("vanilla cupcake")
                recipes_nk << {name: recipe_name, type: "vanilla", url: recipe_url, source: "Natasha's Kitchen"}
            elsif recipe_name.include("chocolate cupcake")
                recipes_nk << {name: recipe_name, type: "chocolate", url: recipe_url, source: "Natasha's Kitchen"}
            elsif recipe_name.include("cupcake")
                recipes_nk << {name: recipe_name, type: "lucky", url: recipe_url, source: "Natasha's Kitchen"}
            end
        }
        recipes_nk
    end

    def self.scrape_nk_recipe(recipe_url)
        doc = Nokogiri::HTML(open(recipe_url))
        recipe = {ingredients: nil, directions: nil}

        doc.css("wprm-recipe-ingredients").each {|ingredient|
            
        
        }


    end

    def self.scrape_ssr
        doc = Nokogiri::HTML(open("https://sugarspunrun.com/recipe-index/"))
        recipes_ssr = []

        doc.css(".rititle.rinojs.always p a").each {|recipe|
            recipe_name = recipe.text
            recipe_url = recipe.href
            if recipe_name.include("vanilla cupcake")
                recipes_ssr << {name: recipe_name, type: "vanilla", url: recipe_url, source: "Sugar Spun Run"}
            elsif recipe_name.include("chocolate cupcake")
                recipes_ssr << {name: recipe_name, type: "chocolate", url: recipe_url, source: "Sugar Spun Run"}
            elsif recipe_name.include("cupcake")
                recipes_ssr << {name: recipe_name, type: "lucky", url: recipe_url, source: "Sugar Spun Run"}
            end
        }
        recipes_ssr
    end

    def self.scrape_sba
        doc1 = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/")) # page 1 of 4
        doc2 = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/page/2/")) # page 2 of 4
        doc3 = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/page/3/")) # page 3 of 4
        doc4 = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/page/4/")) # page 4 of 4

        #not sure if this works
        doc = [doc1, doc2, doc3, doc4].flatten

        doc.css(".uabb-post-heading.uabb-blog-post-section a").each {|recipe|
        recipe_name = recipe.text
        recipe_url = recipe.href
        if recipe_name.include("vanilla cupcake")
            recipes_sba << {name: recipe_name, type: "vanilla", url: recipe_url, source: "Sally's Baking Addiction"}
        elsif recipe_name.include("chocolate cupcake")
            recipes_sba << {name: recipe_name, type: "chocolate", url: recipe_url, source: "Sally's Baking Addiction"}
        elsif recipe_name.include("cupcake")
            recipes_sba << {name: recipe_name, type: "lucky", url: recipe_url, source: "Sally's Baking Addiction"}
        end
        }
        recipes_sba
    end

end