class DashboardController < ApplicationController

  skip_before_action :require_login, only: [:login]

  def recipe
    @recipe = Recipe.get_recipe
  end

  def login
  end

  def show
    @email = cookies.signed["email"]
  end

end
