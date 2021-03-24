require 'rails_helper'

def log_in(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'
end

def request_friend(user, cod)
  log_in(user)
  visit users_path
  find(cod).click
end

RSpec.feature 'Friendship', type: :feature do
  before(:all) do
    @elliot = FactoryBot.create(:user, name: 'Elliot', email: 'el@nw.co')
    @darlene = FactoryBot.create(:user, name: 'Darlene', email: 'da@nw.co')
  end

  scenario 'request friendship should be successful' do
    request_friend(@elliot, "#RQ#{@darlene.id}")
    expect(page).to have_content('Pending')
    click_link 'Sign out'
  end

  scenario 'accept friend request should be successful' do
    request_friend(@darlene, "#RQ#{@elliot.id}")
    click_link 'Sign out'

    log_in(@elliot)
    visit users_path
    find("#AC#{@darlene.id}").click
    expect(page).to have_content('Friend')
  end

  scenario 'refuse friend request should be successful' do
    @new_user = FactoryBot.create(:user)
    request_friend(@new_user, "#RQ#{@darlene.id}")
    click_link 'Sign out'

    log_in(@darlene)
    visit users_path
    find("#RF#{@new_user.id}").click
    expect(page).to have_content('Friend Request')
  end
end
