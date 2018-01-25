require 'rails_helper'

RSpec.feature "Hiding signin link" do
    before do
        @patty = User.create!(email: "patty@example.com", password: "password")
    end
    
    scenario "upon successfull signin" do
        visit '/'
        
        click_link "Sign in"
        fill_in "Email", with: @patty.email
        fill_in "Password", with: @patty.password
        click_button "Log in"
        
        expect(page).to have_link("Sign out")
        expect(page).not_to have_link("Sign in")
        expect(page).not_to have_link("Sign up")
    end
end