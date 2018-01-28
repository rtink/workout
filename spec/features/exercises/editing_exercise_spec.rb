require "rails_helper"

RSpec.feature "Editing Exercise" do
  before do
     @patty = User.create!(first_name: "Patty", 
                        last_name: "Arquette",
                        email: "patty@example.com", 
                        password: "password")
    
    @patty_exercise = @patty.exercises.create!(duration_in_min: 48,
                                                workout: "My workout activity",
                                                workout_date: Date.today)
    login_as(@patty)
  end
  
  scenario "with valid data succeeds" do
    visit '/'
    
    click_link "My Lounge"
    
    path = "/users/#{@patty.id}/exercises/#{@patty_exercise.id}/edit"
    link = "a[href=\'#{path}\']"
    find(link).click
    
    fill_in "Duration", with: 45
    click_button "Update Exercise"
    
    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(45)
    expect(page).not_to have_content(48)
  end
end