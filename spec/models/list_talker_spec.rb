require 'spec_helper'

describe ListTalker do
  before :each do
    @user = User.create(email: "email@example.com")
    @recipe1 = Recipe.get_recipe
    @recipe2 = Recipe.get_recipe
    @recipes = [@recipe1, @recipe2]
    @list = ListBuilder.new(@user, @recipes)
    @list_talker = ListTalker.new
  end
  it "setups up a connection" do
     response = @list_talker.setup_connection
     expect(response.class).to eq Faraday::Connection
  end

  it "posts a list", :vcr do
    response = @list_talker.post_list(@list.to_send)
    expect(response.status).to eq 201
  end
end
