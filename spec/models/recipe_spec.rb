require 'spec_helper'

describe Recipe do

  before do
    @returned_recipe = Recipe.get_recipe
  end

  it "returns a recipe", :vcr do
    expect(@returned_recipe.class).to eq(Recipe)
  end

  it "returns the image url", :vcr do
    expect(@returned_recipe.image_url).to_not eq(nil)
  end

  it 'returns the name', :vcr do
    expect(@returned_recipe.name).to eq("Thai Basil Chicken with Cashew")
  end

  it 'returns the source url', :vcr do 
    expect(@returned_recipe.source_url).to eq("http://simplyrecipes.com/recipes/marcs_cashew_chicken/")
  end

  it 'returns the number of servings', :vcr do
    expect(@returned_recipe.servings).to eq("5")
  end

  it 'returns the ingredients', :vcr do 
    expect(@returned_recipe.ingredients).to eq(["2 apples, cored and quartered", "12 shallots, peeled", "1 bunch thyme", "2 tablespoons olive oil, divided", "1 3-4 pound chicken, rinsed and patted dry with paper towel", "kosher salt and cracked black pepper"])
  end

end
