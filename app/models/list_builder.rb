class ListBuilder

  def initialize(user, recipes)
    @user = user
    @recipes = recipes
  end

  def to_send
    @recipe.to_json
  end

end
