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

  scenario 'stops displaying the log in link after a successful signup' do
    user = FactoryBot.attributes_for(:user)

    visit '/#/signup'
    fill_in'Email:', with: user[:email]
    fill_in'Password:', with: user[:password]
    click_button('Sign Up!')

    expect(page).to_not have_content 'Log In'
  end

  scenario 'stops displaying the sign up link after a successful signup' do
    user = FactoryBot.attributes_for(:user)

    visit '/#/signup'
    fill_in'Email:', with: user[:email]
    fill_in'Password:', with: user[:password]
    click_button('Sign Up!')

    expect(page).to_not have_content 'Sign Up'
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

  scenario 'it has a link to the login page' do
    visit '/#/'
    expect(page).to have_link("Log in", href: '#/login')
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

  scenario 'stops displaying the log in link after a successful login' do
    user = FactoryBot.attributes_for(:user)

    visit '/#/login'
    fill_in'Email:', with: @user.email
    fill_in'Password:', with: @user.password
    click_button('Log In!')

    expect(page).to_not have_content 'Log In'
  end

  scenario 'stops displaying the sign up link after a successful login' do
    user = FactoryBot.attributes_for(:user)

    visit '/#/login'
    fill_in'Email:', with: @user.email
    fill_in'Password:', with: @user.password
    click_button('Log In!')

    expect(page).to_not have_content 'Sign Up'
  end
end

feature 'the log out process', js: true do
  before do
    ActionController::Base.allow_forgery_protection = true
    @user = FactoryBot.create(:user)
  end

  after do
    ActionController::Base.allow_forgery_protection = false
  end

  before :each do 
    visit '/#/login'
    fill_in'Email:', with: @user.email
    fill_in'Password:', with: @user.password
    click_button('Log In!')
    click_button('Logout')
  end

  scenario 'redirects to the log in page on clicking the logout button' do 
    # Because the react_path script is run synchronously, if we test for it
    # immediately after hitting the logout button, the test will fail
    # therefore, we need to make the test wait manually 
    sleep(5)
    expect(react_path).to eq('/login');
  end

  scenario 'stops displaying the logout button on clicking the logout button' do
    expect(page).to_not have_content 'Logout'
  end

  scenario 'displays a log in link on clicking the logout button' do
    expect(page).to have_link("Log in", href: '#/login')
  end

  scenario 'displays a sign up link on clicking the logout button' do
    expect(page).to have_link("Sign up", href: '#/signup')
  end
end

def react_path
  url = evaluate_script('document.location.href')
  react_path = url.split('#')[1]
end
