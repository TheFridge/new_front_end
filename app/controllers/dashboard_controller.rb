class DashboardController < ApplicationController

  skip_before_action :require_login, only: [:login]

  def recipe
    @recipe = Recipe.get_recipe
  end

  def login
    redirect_to dashboard_path if current_user
  end

  def show
    @recipe = Recipe.get_recipe
  end

  def cupboard
  end

end
