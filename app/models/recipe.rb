class Recipe

  attr_reader :image_url, :name, :source_url, :servings, :ingredients, :id, :ingredient_list, :total_time

  def initialize(params)
    @id = params['recipe']['recipe']['id']
    @image_url = params['recipe']['recipe']['image_url']
    @name = params['recipe']['recipe']['name']
    @source_url = params['recipe']['recipe']['source_url']
    @servings = params['recipe']['recipe']['servings']
    @ingredients = []
    params['ingredients'].each do |ingredient|
      @ingredients << ingredient['ingredient']['description']
    end
    @ingredient_list = if params['recipe']['recipe']['ingredient_list'] then params['recipe']['recipe']['ingredient_list'].split('/') end
    @total_time = params['recipe']['recipe']['total_time']
  end

  def self.get_recipe
    response = Faraday.get("http://recipemama.herokuapp.com")
    new(JSON.parse(response.body))
  end

  def self.get_recipe_by_id(id)
    response = Faraday.get("http://recipemama.herokuapp.com/#{id}")
    new(JSON.parse(response.body))
  end

  def self.get_cupboard_recipe(user_id)
    conn = Faraday.new("http://recipemama.herokuapp.com")
    #conn = Faraday.new("http://localhost:4567")

    @cupboard = CupboardTalker.get_cupboard_for_user(user_id)

    if @cupboard['ingredients'].any?
      ingredients = {'ingredients' => @cupboard['ingredients'].collect {|i| i['name']}}
    else
      ingredients = {'ingredients' => ['']}
    end

    response = conn.post do |req|
      req.url "/by_ingredient"
      req.headers['Content-Type'] = 'application/json'
      req.body = ingredients.to_json
    end

    recipe = JSON.parse(response.body)
    formatted_recipe = format_recipe_response(recipe)
    if recipe['recipe'].keys.include?('recipe')
      new(recipe)
    else
      new(formatted_recipe)
    end
  end

  def self.format_recipe_response(recipe)
    mapped_ingredients = recipe['ingredients'].map do |ingredient|
      {'ingredient' => ingredient}
    end

    {'recipe' => {'recipe' => recipe['recipe']}, 'ingredients' => mapped_ingredients}
  end

end
