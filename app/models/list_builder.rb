class ListBuilder

  def initialize(recipe, user_id)
    @recipe = recipe
    @user_id = user_id
  end

  def to_send
    @recipe.to_json
  end

end
