# frozen_string_literal: true

require 'application_system_test_case'

class SessionsSystemTest < ApplicationSystemTestCase
  it 'allows a user to log in then log out' do
    visit root_path

    click_link 'Log in'

    fill_in 'Email', with: users(:dave).email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    assert_text 'You are now logged in!'
    assert_current_path root_path

    click_link 'Sign out'
    assert_text 'You are now logged out!'
    assert_current_path root_path
  end

  it 'allows a user to register then log out' do
    visit root_path

    click_link 'Register'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Register'

    assert_text 'Your account was created successfully'
    assert_current_path root_path

    click_link 'Sign out'
    assert_text 'You are now logged out!'
    assert_current_path root_path
  end

  it 'does not allow a user to log in with invalid credentials' do
    visit root_path

    click_link 'Log in'
    assert_current_path new_session_path

    fill_in 'Email', with: users(:dave).email
    fill_in 'Password', with: 'incorrect password'
    click_button 'Log in'

    assert_text 'Those details are incorrect - please try again!'
    assert_current_path sessions_path
  end

  it 'does not allow a user to register with invalid credentials' do
    visit root_path

    click_link 'Register'
    assert_current_path new_registration_path

    fill_in 'Email', with: 'invalid_email'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Register'

    assert_text 'There was a problem creating your account.'
    assert_current_path registrations_path
  end
end
