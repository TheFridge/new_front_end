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
    @ingredient_list = params['recipe']['recipe']['ingredient_list'].split('/')
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

    @cupboard = CupboardTalker.get_cupboard_for_user(user_id)

    ingredients = {'ingredients' => @cupboard['ingredients'].collect {|i| i['name']}}

    response = conn.post do |req|
      req.url "/by_ingredient"
      req.headers['Content-Type'] = 'application/json'
      req.body = ingredients.to_json
    end

    #raise response

    new(JSON.parse(response.body))
  end

end
