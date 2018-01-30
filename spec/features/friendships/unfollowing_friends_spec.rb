require "rails_helper"

RSpec.feature "Showing Friend Workout" do
  before do
    @patty = User.create!(first_name: "Patty", 
                        last_name: "Arquette",
                        email: "patty@example.com", 
                        password: "password")
     @ajcook = User.create!(first_name: "Aj", 
                        last_name: "Cook",
                        email: "ajcook@example.com", 
                        password: "password")
                                  
    login_as(@patty)
    
    @following = Friendship.create(user: @patty, friend: @ajcook)
  end
  
  scenario do
    visit '/'
    
    click_link "My Lounge"
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click
    
    expect(page).to have_content(@ajcook.full_name + " unfollowed")
  end
end