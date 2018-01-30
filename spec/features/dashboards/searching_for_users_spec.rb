require "rails_helper"

RSpec.feature "Searching for User" do
  before do
    @patty = User.create!(first_name: "Patty",
                         last_name: "Arquette",
                         email: "patty@example.com",
                         password: "password")
                         
    @avery = User.create!(first_name: "Avery",
                         last_name: "Arquette",
                         email: "avery@example.com",
                         password: "password")
  end
  
  scenario "with existing name returns all those users" do
    visit '/'
    
    fill_in "search_name", with: "Arquette"
    click_button "Search"
    
    expect(page).to have_content(@patty.full_name)
    expect(page).to have_content(@avery.full_name)
    expect(current_path).to eq("/dashboards/search")
  end
end