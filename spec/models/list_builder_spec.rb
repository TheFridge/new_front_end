require 'spec_helper'

describe ListBuilder do

  xit "can build a list", :vcr do
    @recipe = Recipe.get_recipe
    @list = ListBuilder.new(@recipe, 1)
    expect(@list.to_send.class).to eq(Hash)
  end

end
