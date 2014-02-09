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
    @cupboard = CupboardTalker.get_cupboard_for_user(current_user.id)
  end

  def list
    @recipe = Recipe.get_recipe_by_id(params[:recipe_id])
    list_builder = ListBuilder.new(current_user, @recipe).to_send
    list_talker = ListTalker.new
    list = list_talker.send(list_builder)
    redirect_to dashboard_path(list: list.body)
  end

  def populate_cupboard
    # if CupboardTalker.save_to_cupboard(params[:list])
    #  flash[:notice] = 'Items have been added to your cupboard'
    #  redirect_to cupboard_path
    # else
    #  flash[:notice] = 'There was an error, and your cupboard is empty'
    #  redirect_to :back
    # end
  end
end
