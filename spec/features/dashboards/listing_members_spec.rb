require "rails_helper"

RSpec.feature "Listing Members" do
  before do
    @patty = User.create(first_name: "Patty",
                         last_name: "Arquette",
                         email: "patty@example.com",
                         password: "password")
                         
    @avery = User.create(first_name: "Avery",
                         last_name: "Arquette",
                         email: "avery@example.com",
                         password: "password")
  end
  
  scenario "shows a list of registered members" do
    visit '/'
    
    expect(page).to have_content("List of Members")
    expect(page).to have_content(@patty.full_name)
    expect(page).to have_content(@avery.full_name)
  end
end