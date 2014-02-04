require 'spec_helper'

describe Recipe do

  before do
    @returned_recipe = Recipe.get_recipe
  end

  it "returns a recipe", :vcr do
    expect(@returned_recipe.instance_variables).to include(:@ingredients)
  end

  it "returns the image url", :vcr do
    expect(@returned_recipe.image_url).to_not eq(nil)
  end

  it 'returns the name', :vcr do
    expect(@returned_recipe.name).to eq("Thai Basil Chicken with Cashew")
  end

end
