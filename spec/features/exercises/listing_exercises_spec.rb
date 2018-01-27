require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
    @patty = User.create(email: "patty@example.com", password: "password")
    login_as(@patty)
    
    @e1 = @patty.exercises.create(duration_in_min: 20,
                                  workout: "Dancing",
                                  workout_date: Date.today)
    
    @e2 = @patty.exercises.create(duration_in_min: 60,
                                  workout: "Thred Mill",
                                  workout_date: Date.today)
  end
  
  scenario "shows user's workout for last 7 days" do
    visit '/'
    
    click_link "My Lounge"
    
    expect(page).to have_content(@e1.duration_in_min)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)
    
    expect(page).to have_content(@e2.duration_in_min)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)
    
    # expect(page).not_to have_content(@e3.duration_in_min)
    # expect(page).not_to have_content(@e3.workout)
    # expect(page).not_to have_content(@e3.workout_date)
  end
  
  scenario "shows no exercises if none created" do
    @patty.exercises.delete_all
    
    visit '/'
    
    click_link "My Lounge"
    
    expect(page).to have_content("No Workouts Yet")
    
  end
end