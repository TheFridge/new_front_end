class ListBuilder

  attr_reader :user, :recipes

  def initialize(user, recipes)
    @user = user
    @recipes = [recipes].flatten
  end

  def format_user_information
    {"user_id" => user.id, "email" => user.email}
  end

  def format_recipes
    recipes.map do |recipe|
      {"name" => recipe.name, "source_url" => recipe.source_url, "servings" => recipe.servings, "ingredients" => recipe.ingredients, 'ingredient_list' => recipe.ingredient_list}
    end
  end

  def prepared_to_send
    {"user" => format_user_information, "recipes" => format_recipes}
  end

  def to_send
    prepared_to_send.to_json
  end

end
