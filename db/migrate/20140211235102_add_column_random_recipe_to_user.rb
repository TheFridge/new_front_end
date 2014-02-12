class AddColumnRandomRecipeToUser < ActiveRecord::Migration
  def change
    add_column :users, :random, :boolean, default: true
  end
end
