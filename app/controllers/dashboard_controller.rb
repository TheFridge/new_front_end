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
    @list = ListTalker.new.find(JSON.parse(params[:list])["id"]) if params[:list]
  end

  def cupboard
  end

  def list
    @recipe = Recipe.get_recipe_by_id(params[:recipe_id])
    list_builder = ListBuilder.new(current_user, @recipe).to_send
    list_talker = ListTalker.new
    list = list_talker.send(list_builder)
    redirect_to dashboard_path(list: list.body)
  end
end
