require 'spec_helper'

describe ListBuilder do

  before do
    @user = User.new(email: "email@example.com")
    recipe1 = Recipe.get_recipe
    recipe2 = Recipe.get_recipe
    @recipes = [recipe1, recipe2]
    @list = ListBuilder.new(@user, @recipes)
    @list_builder_hash = JSON.parse(@list.to_json)
  end

  it "can format to JSON output with to_send", :vcr do
    expect(@list.to_send.class).to eq(String)
  end

  it "has correct hash keys", :vcr do
    expect(@list_builder_hash.keys).to eq(["user", "recipes"])
  end

  it "correctly formats user information", :vcr do
    expect(@list.format_user_information.keys).to eq(["user_id", "email"])
    expect(@list.format_user_information['email']).to eq("email@example.com")
    expect(@list.format_user_information['user_id']).to eq(@user.id)
  end

  it "correctly formats recipes information", :vcr do
    expect(@list.format_recipes.class).to eq(Array)
    expect(@list.format_recipes.count).to eq(2)
    expect(@list.format_recipes.first.keys).to eq(["name", "source_url", "servings", "ingredients"])
  end

  it "correctly formats prepared to send information", :vcr do
    expect(@list.prepared_to_send.keys).to eq(["user", "recipes"])
  end

end
