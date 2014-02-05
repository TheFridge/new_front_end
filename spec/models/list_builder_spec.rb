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

  it "correctly formats user information", :vcr do
    expect(@list.format_user_information.keys).to eq(["user_id", "email"])
    expect(@list.format_user_information['email']).to eq("email@example.com")
    expect(@list.format_user_information['user_id']).to eq(@user.id)
  end

  it "correctly formats prepared to send information", :vcr do
    expect(@list.prepared_to_send.keys).to eq(["user", "recipes"])
  end

end
