require 'rails_helper'

feature 'the signup process', js: true do
  scenario 'has a registration page' do
    visit '/#/register'
    expect(page).to have_content 'Sign Up for EverydayBudget'
  end
end
