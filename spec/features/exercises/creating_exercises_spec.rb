require 'rails_helper'

RSpec.feature "Creating Exercise" do
  before do
    @patty = User.create!(email: "patty@example.com", password: "password")
    login_as(@patty)
    
    visit '/'
    
    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_link("Back")
  end
  
  scenario "with valid inputs" do
    fill_in "Duration (min)", with: 70
    fill_in "Workout Details", with: "Weight lifting"
    fill_in "Activity Date", with: "2018-01-26"
    click_button "Create Exercise"
    
    expect(page).to have_content("Exercise has been created")
    
    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@patty, exercise))
    expect(exercise.user_id).to eq(@patty.id)
  end
  
  scenario "with invalid inputs" do
      
    fill_in "Duration", with: nil
    fill_in "Workout Details", with: ""
    fill_in "Activity Date", with: ""
    click_button "Create Exercise"
    
    expect(page).to have_content("Exercise has not been created")
    expect(page).to have_content("Duration in min is not a number")
    expect(page).to have_content("Workout details can't be blank")
    expect(page).to have_content("Activity date can't be blank")
  end
    
end