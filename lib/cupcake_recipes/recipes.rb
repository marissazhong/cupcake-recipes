require 'open-uri'

class CupcakeRecipes::Recipes
    # nk = Natasha's Kitchen
    # ssr = Sugar Spun Run
    # sba = Sally's Baking Addiction
    @@all = []
    attr_accessor :name, :type, :url, :source, :recipe

    def initialize(attributes)
        attributes.each {|k,v| self.send(("#{k}="),v)}
    end

    def self.all
        @@all
    end

    def self.create_cupcake(recipe_name, recipe_url, blog_name, recipes_arr)
        if recipe_name.include?("Cupcake") && !recipes_arr.any?{|recipe| recipe.name == recipe_name}
            new_cupcake = CupcakeRecipes::Recipes.new({name: recipe_name, url: recipe_url, source: blog_name})
            if recipe_name.include?("Vanilla Cupcake")
                    new_cupcake.type = "Vanilla"
            elsif recipe_name.include?("Chocolate Cupcake")
                    new_cupcake.type = "Chocolate"
            else
                    new_cupcake.type = "Lucky"
            end
            self.all << new_cupcake
        end
    end
 
end
