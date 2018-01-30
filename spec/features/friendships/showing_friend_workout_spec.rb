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
    
    @e1 = @patty.exercises.create(duration_in_min: 20,
                                  workout: "Dancing with Avery",
                                  workout_date: Date.today)
    
    @e2 = @ajcook.exercises.create(duration_in_min: 60,
                                  workout: "Threadmill",
                                  workout_date: 2.days.ago)
                                  
    login_as(@patty)
    
    @following = Friendship.create(user: @patty, friend: @ajcook)
  end
  
  scenario "shows friend's workout for last 7 days" do
    visit '/'
    
    click_link "My Lounge"
    click_link @ajcook.full_name
    
    expect(page).to have_content(@ajcook.full_name + "'s Exercises")
    expect(page).to have_content(@e2.workout)
    expect(page).to have_css("div#chart")
  end
  
end