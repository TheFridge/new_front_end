require 'spec_helper'

describe ListBuilder do

  before do
    @user = User.create(email: "email@example.com")
    @recipe1 = Recipe.get_recipe
    @recipe2 = Recipe.get_recipe
    @recipes = [@recipe1, @recipe2]
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

  def correct_data
    {
    "user" => {
      "user_id" => @user.id,
      "email" => @user.email
     },
     "recipes" => [
        {"name" => @recipe1.name,
        "source_url" => @recipe1.source_url,
        "servings" => @recipe1.servings,
        "ingredients" => @recipe1.ingredients
        },
        {"name" => @recipe2.name,
        "source_url" => @recipe2.source_url,
        "servings" => @recipe2.servings,
        "ingredients" => @recipe2.ingredients
        }
      ]
    }
  end

  it "correctly formats prepared to send information", :vcr do
    expect(@list.prepared_to_send.keys).to eq(["user", "recipes"])
    expect(@list.prepared_to_send).to eq(correct_data)
  end

  it "handles only receiving one recipe", :vcr do
    one_recipe = @recipe1
    list_one = ListBuilder.new(@user, one_recipe)
    new_data = {
    "user" => {
      "user_id" => @user.id,
      "email" => @user.email
     },
     "recipes" => [
        {"name" => one_recipe.name,
        "source_url" => one_recipe.source_url,
        "servings" => one_recipe.servings,
        "ingredients" => one_recipe.ingredients
        }
      ]
    }
    expect(list_one.prepared_to_send).to eq(new_data)
  end

end
