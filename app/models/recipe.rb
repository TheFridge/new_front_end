class Recipe

  attr_reader :image_url, :name, :source_url, :servings, :ingredients

  def initialize(params)
    @image_url = params['recipe']['recipe']['image_url']
    @name = params['recipe']['recipe']['name']
    @source_url = params['recipe']['recipe']['source_url']
    @servings = params['recipe']['recipe']['servings']
    @ingredients = []
    params['ingredients'].each do |ingredient|
      @ingredients << ingredient['ingredient']['description']
    end
  end

  def self.get_recipe
    response = Faraday.get("http://recipemama.herokuapp.com")
    new(JSON.parse(response.body))
  end

end
