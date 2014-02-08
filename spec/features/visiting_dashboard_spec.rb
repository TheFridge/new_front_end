require_relative '../spec_helper.rb'

describe 'visiting dashboard', type: :feature do
  before :all do
    User.create(email: "joe@example.com")
  end

  it 'has links to cupboard and recipes', :vcr do
    visit dashboard_path
    within('.sidebar-nav') do
      expect(page).to have_content('Cupboard')
    end
  end

  it 'displays a recipe', :vcr do
    visit recipe_path

    within('#recipe') do
      expect(page).to have_content('Ingredients')
    end
  end

  it "when I click add to cupboard", :vcr do
    visit dashboard_path
    click_on "Add to Shopping List"
    within('.list') do
      expect(page).to have_content(/[a-z]+/)
    end
  end

  it "when I click on Cupboard" do
    visit dashboard_path
    within('.sidebar-nav') do
      click_on "Cupboard"
    end
    expect(page).to have_content("Your Cupboard")
  end

  it 'adds items from shopping list to cupboard', :vcr do
    visit dashboard_path
    click_on "Add to Shopping List"
    within('.list') do
      click_on "I've got this shiz"
    end
    expect(page).to have_content("3 teaspoons of Parsley")
  end

end
