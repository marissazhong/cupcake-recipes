require 'open-uri'

class CupcakeRecipes::Recipes
    # nk = Natasha's Kitchen
    # ssr = Sugar Spun Run
    # sba = Sally's Baking Addiction

    attr_accessor :name, :type, :url, :source

    def self.scrape_recipes
        recipes_vanilla, recipes_chocolate, recipes_lucky = [], [], []

        recipes_vanilla = [self.scrape_nk[0], self.scrape_ssr[0], self.scrape_sba[0]].flatten!(1)
        recipes_chocolate = [self.scrape_nk[1], self.scrape_ssr[1], self.scrape_sba[1]].flatten!(1)
        recipes_lucky = [self.scrape_nk[2], self.scrape_ssr[2], self.scrape_sba[2]].flatten!(1)

        recipes = [recipes_vanilla, recipes_chocolate, recipes_lucky]
    end

    def self.scrape_nk
        doc = Nokogiri::HTML(open("https://natashaskitchen.com/category/dessert/cupcakes/"))
        recipes_vanilla, recipes_chocolate, recipes_lucky = [], [], []

        doc.css("div.li-a a").each {|recipe| 
            recipe_name = recipe.text
            recipe_url = recipe.href
            if recipe_name.include("vanilla cupcake")
                recipes_vanilla << {name: recipe_name, type: "vanilla", url: recipe_url, source: "Natasha's Kitchen"}
            elsif recipe_name.include("chocolate cupcake")
                recipes_chocolate << {name: recipe_name, type: "chocolate", url: recipe_url, source: "Natasha's Kitchen"}
            elsif recipe_name.include("cupcake")
                recipes_lucky << {name: recipe_name, type: "lucky", url: recipe_url, source: "Natasha's Kitchen"}
            end
        }
        recipes_nk = [recipes_vanilla, recipes_chocolate, recipes_lucky]
    end

    def self.scrape_nk_recipe(recipe_url)
        doc = Nokogiri::HTML(open(recipe_url))
        recipe = {ingredients: nil, directions: nil}

        doc.css("wprm-recipe-ingredients").each {|ingredient|

        
        }


    end

    def self.scrape_ssr
        doc = Nokogiri::HTML(open("https://sugarspunrun.com/recipe-index/"))
        recipes_vanilla, recipes_chocolate, recipes_lucky = [], [], []

        doc.css(".rititle.rinojs.always p a").each {|recipe|
            recipe_name = recipe.text
            recipe_url = recipe.href
            if recipe_name.include("vanilla cupcake")
                recipes_vanilla << {name: recipe_name, type: "vanilla", url: recipe_url, source: "Sugar Spun Run"}
            elsif recipe_name.include("chocolate cupcake")
                recipes_chocolate << {name: recipe_name, type: "chocolate", url: recipe_url, source: "Sugar Spun Run"}
            elsif recipe_name.include("cupcake")
                recipes_lucky << {name: recipe_name, type: "lucky", url: recipe_url, source: "Sugar Spun Run"}
            end
        }
        recipes_ssr = [recipes_vanilla, recipes_chocolate, recipes_lucky]
    end

    def self.scrape_sba
        doc1 = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/")) # page 1 of 4
        doc2 = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/page/2/")) # page 2 of 4
        doc3 = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/page/3/")) # page 3 of 4
        doc4 = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/page/4/")) # page 4 of 4
        #not sure if this works
        doc = [doc1, doc2, doc3, doc4].flatten
        recipes_vanilla, recipes_chocolate, recipes_lucky = [], [], []

        doc.css(".uabb-post-heading.uabb-blog-post-section a").each {|recipe|
        recipe_name = recipe.text
        recipe_url = recipe.href
        if recipe_name.include("vanilla cupcake")
            recipes_vanilla << {name: recipe_name, type: "vanilla", url: recipe_url, source: "Sally's Baking Addiction"}
        elsif recipe_name.include("chocolate cupcake")
            recipes_chocolate << {name: recipe_name, type: "chocolate", url: recipe_url, source: "Sally's Baking Addiction"}
        elsif recipe_name.include("cupcake")
            recipes_lucky << {name: recipe_name, type: "lucky", url: recipe_url, source: "Sally's Baking Addiction"}
        end
        }
        recipes_sba = [recipes_vanilla, recipes_chocolate, recipes_lucky]
    end

end