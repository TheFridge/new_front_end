class DashboardController < ApplicationController

  def recipe
    @recipe = Recipe.get_recipe
  end

end
