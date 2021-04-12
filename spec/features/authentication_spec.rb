require 'rails_helper'

feature 'the signup process', js: true do
  before do
      ActionController::Base.allow_forgery_protection = true
  end

  after do
      ActionController::Base.allow_forgery_protection = false
  end

  scenario 'has a registration page' do
    visit '/#/signup'
    expect(page).to have_content 'Sign Up for EverydayBudget'
  end

  scenario 'redirects a user to the home page after a successful signup' do 
    user = FactoryBot.attributes_for(:user)

    visit '/#/signup'
    fill_in'Email:', with: user[:email]
    fill_in'Password:', with: user[:password]
    click_button('Sign up!')

    expect(react_path).to eq('/signup');
  end

  scenario 'displays the user\'s email after a successful signup' do
    user = FactoryBot.attributes_for(:user)

    visit '/#/signup'
    fill_in'Email:', with: user[:email]
    fill_in'Password:', with: user[:password]
    click_button('Sign up!')

    expect(page).to have_content user[:email]
  end

  scenario 'display a logout button after a successful signup' do
    user = FactoryBot.attributes_for(:user)

    visit '/#/signup'
    fill_in'Email:', with: user[:email]
    fill_in'Password:', with: user[:password]
    click_button('Sign up!')

    expect(page).to have_content 'Logout'
  end
end

def react_path
  url = evaluate_script('document.location.href')
  react_path = url.split('#')[1]
end
