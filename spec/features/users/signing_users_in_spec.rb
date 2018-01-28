require "rails_helper"

RSpec.feature "Users signin" do
 
  before do
     @patty = User.create!(first_name: "Patty", 
                        last_name: "Arquette",
                        email: "patty@example.com", 
                        password: "password")
  end
 
  scenario "with valid credentials" do
    visit "/"
   
    click_link "Sign in"
    fill_in "Email", with: @patty.email
    fill_in "Password",  with: @patty.password
    click_button "Log in"
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@patty.email}")
  end
end