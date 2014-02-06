class DashboardController < ApplicationController

  skip_before_action :require_login, only: [:login]

  def recipe
    @recipe = Recipe.get_recipe
  end

  def login
  end

  def show
    @recipe = Recipe.get_recipe
  end

  def cupboard
  end

  def list
    @recipe = Recipe.get_recipe_by_id(params[:recipe_id])
    list_builder = ListBuilder.new(current_user, @recipe).to_send
  end
end
