class DashboardController < ApplicationController

  def recipe
    @recipe = Recipe.get_recipe
  end

  def login
  end

end
