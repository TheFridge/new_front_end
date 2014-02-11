class DashboardController < ApplicationController

  skip_before_action :require_login, only: [:login]

  def recipe
    @recipe = Recipe.get_recipe
    @recipes = ListTalker.new.get_recipes(current_user.id)
    @list = ListTalker.new.find(current_user.id)
  end

  def login
    redirect_to dashboard_path if current_user
  end

  def logout
    cookies.delete "email", domain: "herokuapp.com"
    cookies.delete "user_id", domain: "herokuapp.com"
    redirect_to root_path
  end

  def show
    @recipe = Recipe.get_recipe
    @recipes = ListTalker.new.get_recipes(current_user.id)
    @list = ListTalker.new.find(current_user.id)
  end

  def cupboard
    @list = ListTalker.new.find(current_user.id)
    @recipes = ListTalker.new.get_recipes(current_user.id)
    @cupboard = CupboardTalker.get_cupboard_for_user(current_user.id)
    @ingredients = @cupboard['ingredients'].sort_by {|i| i['name']}.reverse
  end

  def shopping_list
    @list = ListTalker.new.find(current_user.id)
    @recipes = ListTalker.new.get_recipes(current_user.id)
  end

  def clear_list
    ListTalker.new.empty_list(current_user.id)
    redirect_to shopping_list_path
  end

  def favorites
    @recipes = ListTalker.new.get_recipes(current_user.id)
    @list = ListTalker.new.find(current_user.id)
  end

  def destroy_list_item
    @list = ListTalker.new
    @list.destroy_item(params[:id])
    redirect_to shopping_list_path
  end

  def email_list
    ListTalker.new.email_list(current_user.id)
    flash[:notice] = "Your list was sent to #{current_user.email}"
    redirect_to shopping_list_path
  end

  def list
    @recipe = Recipe.get_recipe_by_id(params[:recipe_id])
    list_builder = ListBuilder.new(current_user, @recipe).to_send
    list_talker = ListTalker.new
    list = JSON.parse(list_talker.send(list_builder).body)
    session[:list_id] = list['shopping_list']['id']
    redirect_to dashboard_path
  end

  def populate_cupboard
    if CupboardTalker.save_to_cupboard(session[:list_id], current_user.id)
     flash[:notice] = 'Items have been added to your cupboard'
     redirect_to cupboard_path
    else
     flash[:notice] = 'There was an error, and your cupboard is empty'
     redirect_to :back
    end
  end

  def drop_from_cupboard
    CupboardTalker.drop_from_cupboard(params[:id], current_user.id)
    redirect_to cupboard_path
  end

  def update_quantity
    CupboardTalker.update_ingredient_quantity(params[:id], params[:quantity], current_user.id)
    flash[:notice] = "Your quantity has been updated"
    redirect_to cupboard_path
  end

  def home
    @recipes = ListTalker.new.get_recipes(current_user.id)
    @list = ListTalker.new.find(current_user.id)
  end

end
