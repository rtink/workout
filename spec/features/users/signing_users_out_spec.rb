require "rails_helper"

RSpec.feature "Signing users out" do 
    before do
        @patty = User.create!(first_name: "Patty", 
                        last_name: "Arquette",
                        email: "patty@example.com", 
                        password: "password")
        
        visit '/'
        click_link "Sign in"
        fill_in "Email", with: @patty.email
        fill_in "Password", with: @patty.password
        click_button "Log in"
    end
    
    scenario do
        visit '/'
        click_link "Sign out"
        expect(page).to have_content("Signed out successfully.")
    end
end