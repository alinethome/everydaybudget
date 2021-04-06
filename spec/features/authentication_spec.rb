require 'rails_helper'

feature 'the signup process', js: true do
  scenario 'has a registration page' do
    visit '/#/register'
    expect(page).to have_content 'Sign Up for EverydayBudget'
  end

  scenario 'redirects a user to the home page after a successful signup' do 
    user = FactoryBot.attributes_for(:user)

    visit '/#/register'
    fill_in'Email:', with: user[:email]
    fill_in'Password:', with: user[:password]
    click_button('Sign up!')

    expect(current_path).to eq('/');
  end
end
