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
            recipe_url = recipe.attribute('href')
            if recipe_name.include?("vanilla cupcake")
                recipes_vanilla << {name: recipe_name, type: "vanilla", url: recipe_url, source: "Natasha's Kitchen"}
            elsif recipe_name.include?("chocolate cupcake")
                recipes_chocolate << {name: recipe_name, type: "chocolate", url: recipe_url, source: "Natasha's Kitchen"}
            elsif recipe_name.include?("cupcake")
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
            recipe_url = recipe.attribute('href')
            if recipe_name.include?("vanilla cupcake")
                recipes_vanilla << {name: recipe_name, type: "vanilla", url: recipe_url, source: "Sugar Spun Run"}
            elsif recipe_name.include?("chocolate cupcake")
                recipes_chocolate << {name: recipe_name, type: "chocolate", url: recipe_url, source: "Sugar Spun Run"}
            elsif recipe_name.include?("cupcake")
                recipes_lucky << {name: recipe_name, type: "lucky", url: recipe_url, source: "Sugar Spun Run"}
            end
        }
        recipes_ssr = [recipes_vanilla, recipes_chocolate, recipes_lucky]
    end

    def self.scrape_sba
         recipes_vanilla, recipes_chocolate, recipes_lucky = [], [], []

        i = 1
        while i < 5
            if i == 1
                doc = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/"))
            else
                doc = Nokogiri::HTML(open("https://sallysbakingaddiction.com/category/cupcakes/page/#{i}/"))
            end
            doc.css(".uabb-post-heading.uabb-blog-post-section a").each {|recipe|
            recipe_name = recipe.text
            recipe_url = recipe.attribute('href')
            if recipe_name.include?("vanilla cupcake")
                recipes_vanilla << {name: recipe_name, type: "vanilla", url: recipe_url, source: "Sally's Baking Addiction"}
            elsif recipe_name.include?("chocolate cupcake")
                recipes_chocolate << {name: recipe_name, type: "chocolate", url: recipe_url, source: "Sally's Baking Addiction"}
            elsif recipe_name.include?("cupcake")
                recipes_lucky << {name: recipe_name, type: "lucky", url: recipe_url, source: "Sally's Baking Addiction"}
            end
            }
            i += 1
        end
        recipes_sba = [recipes_vanilla, recipes_chocolate, recipes_lucky]
    end

end