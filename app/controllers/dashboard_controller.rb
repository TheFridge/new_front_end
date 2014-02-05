class DashboardController < ApplicationController

  def recipe
    @recipe = Recipe.get_recipe
  end

  def login
  end

  def show
    @email = cookies.signed["email"]
  end

end
