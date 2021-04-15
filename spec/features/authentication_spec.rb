require 'rails_helper'

feature 'the signup process', js: true do
  before do
      ActionController::Base.allow_forgery_protection = true
  end

  after do
      ActionController::Base.allow_forgery_protection = false
  end

  scenario 'it has a link to the registration page' do
    visit '/#/'
    expect(page).to have_link("Sign up", href: '#/signup')
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
    click_button('Sign Up!')

    expect(react_path).to eq('/signup');
  end

  scenario 'displays the user\'s email after a successful signup' do
    user = FactoryBot.attributes_for(:user)

    visit '/#/signup'
    fill_in'Email:', with: user[:email]
    fill_in'Password:', with: user[:password]
    click_button('Sign Up!')

    expect(page).to have_content user[:email]
  end

  scenario 'display a logout button after a successful signup' do
    user = FactoryBot.attributes_for(:user)

    visit '/#/signup'
    fill_in'Email:', with: user[:email]
    fill_in'Password:', with: user[:password]
    click_button('Sign Up!')

    expect(page).to have_content 'Logout'
  end
end

feature 'the log in process', js: true do
  before do
      ActionController::Base.allow_forgery_protection = true

      @user = FactoryBot.create(:user)
  end

  after do
      ActionController::Base.allow_forgery_protection = false
      @user.destroy
  end

  scenario 'has a log in page' do
    visit '/#/login'
    expect(page).to have_content 'Log In'
  end

  scenario 'displays the user\'s email after a successful login' do
    visit '/#/login'
    fill_in'Email:', with: @user.email
    fill_in'Password:', with: @user.password
    click_button('Log In!')

    expect(page).to have_content @user.email
  end

  scenario 'display a logout button after a successful login' do
    visit '/#/login'
    fill_in'Email:', with: @user.email
    fill_in'Password:', with: @user.password
    click_button('Log In!')

    expect(page).to have_content 'Logout'
  end
end

def react_path
  url = evaluate_script('document.location.href')
  react_path = url.split('#')[1]
end
