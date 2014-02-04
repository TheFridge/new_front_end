class Recipe

  attr_reader :image_url, :ingredients, :name

  def initialize(params)
    @image_url = params['recipe']['recipe']['image_url']
    @ingredients = params['recipe']['ingredients']
    @name = params['recipe']['recipe']['name']
  end

  def self.get_recipe
    response = Faraday.get("http://recipemama.herokuapp.com")
    new(JSON.parse(response.body))
  end

end
