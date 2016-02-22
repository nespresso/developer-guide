require 'rails_helper'

describe 'Page title, headline and flash' do
  it 'displays the page title and the headline on the home page' do
    visit root_path

    expect(page).to have_title 'Accessibility Developer Guide'
    expect(page).to have_css 'main h1', text: 'Accessibility Developer Guide'
  end

  it 'displays the page title and the headline on other pages' do
    visit page_path('about')

    expect(page).to have_title 'About - ADG'
    expect(page).to have_css 'main h1', text: 'About'
  end

  context 'with flash' do
    it 'displays the flash in the page title and content' do
      visit root_path
      click_button 'Sign in' # Trigger validation error

      expect(page).to have_title 'Alert: Invalid login or password. Sign in - ADG'
      within 'main' do
        expect(page).to have_css 'h1', text: 'Sign in'
        expect(page).to have_content 'Alert: Invalid login or password'
      end
    end
  end
end
