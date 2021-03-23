require 'rails_helper'

RSpec.feature 'Events', type: :feature do
  before(:all) { FactoryBot.create(:user) }

  def sign_up(user_name)
    visit new_user_registration_path
    within('form') do
      fill_in 'Name', with: user_name
      fill_in 'Email', with: "#{user_name}@nw.co"
      fill_in 'Password', with: '123456789'
      fill_in 'Password confirmation', with: '123456789'
    end

    click_button 'Sign up'
  end

  context 'request friendship with the first user on user index' do
    scenario 'should be successful' do
      sign_up('elliot')
      visit users_path
      find('#COD1').click

      expect(page).to have_content('Pending')
      click_link 'Sign out'
    end
  end
end