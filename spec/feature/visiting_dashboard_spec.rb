require_relative '../spec_helper.rb'

describe 'visiting dashboard' do

  xit 'has links to cupboard and recipes' do
    visit root_path
    within('#nav') do
      expect(page).to have_content('Cupboard')
      expect(page).to have_content('Find Recipes')
    end
  end

  xit 'displays a recipe' do
    visit recipe_path

    within('#recipe') do
      expect(page).to have_content('Ingredients')
    end
  end

end
