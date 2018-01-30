require "rails_helper"

RSpec.feature "Following Friends" do
  before do
    @patty = User.create!(first_name: "Patty",
                         last_name: "Arquette",
                         email: "patty@example.com",
                         password: "password")
                         
    @avery = User.create!(first_name: "Avery",
                         last_name: "Arquette",
                         email: "avery@example.com",
                         password: "password")
                         
    login_as(@patty)
  end
  
  scenario "if signed in" do
    visit '/'
    
    expect(page).to have_content(@patty.full_name)
    expect(page).to have_content(@avery.full_name)
    
    href = "/friendships?friend_id=#{@patty.id}"
    expect(page).not_to have_link("Follow", :href => href)
    
    link = "a[href='/friendships?friend_id=#{@avery.id}']"
    find(link).click
    
    href = "/friendships?friend_id=#{@avery.id}"
    expect(page).not_to have_link("Follow", :href => href)
  end
end