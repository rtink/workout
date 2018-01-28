require "rails_helper"

RSpec.feature "Deleting Exercise" do
  before do
    @patty = User.create!(first_name: "Patty",
                           last_name: "Arquette",
                           email: "patty@example.com",
                           password: "password")
                           
    @patty_exercise = @patty.exercises.create!(duration_in_min: 56,
                                               workout: "My workout activity",
                                               workout_date: Date.today)
    
    login_as(@patty)                    
  end
  
  scenario do
    visit '/'
    
    click_link "My Lounge"
    
    link = "//a[contains(@href,
                '/users/#{@patty.id}/exercises/#{@patty_exercise.id}')
                and .//text()= 'Destroy']"
    find(:xpath, link).click
    
    expect(page).to have_content("Exercise has been deleted")
  end
end