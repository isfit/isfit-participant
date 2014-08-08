require 'test_helper'

class LandingTest < ActionDispatch::IntegrationTest
  test 'valid registration form sends you to dashboard' do
    visit '/'

    within 'h1' do
      assert has_content?('Ready for the ISFiT experience?')
    end

    within '#new_user' do
      fill_in 'Your first name', :with => 'Fred'
      fill_in 'Your last name', :with => 'Apekatt'
      fill_in 'Your e-mail', :with => 'fred@example.com'
      fill_in 'Repeat the e-mail', :with => 'fred@example.com'
      fill_in 'Select a password', :with => 'password'
      fill_in 'Repeat the password', :with => 'password'

      click_button 'Create account'
    end

    within 'h1' do
      assert has_content?('Welcome, Fred Apekatt!')
    end
  end
end
