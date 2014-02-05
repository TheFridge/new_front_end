require 'spec_helper'

describe ListBuilder do

  before do
    @user = User.new(email: "email@example.com")
    @recipe = Recipe.get_recipe
    @list = ListBuilder.new(@user, @recipe)
    @list_builder_hash = JSON.parse(@list.to_json)
  end

  it "can format to JSON output with to_send", :vcr do
    expect(@list.to_send.class).to eq(String)
  end

  it "has correct hash keys", :vcr do
    expect(@list_builder_hash.keys).to eq(["user", "recipes"])
  end

  it "has correct user hash keys", :vcr do
    puts @list_builder_hash["recipes"].inspect
    expect(@list_builder_hash["user"].keys).to eq(["user_id", "email"])
  end

end
