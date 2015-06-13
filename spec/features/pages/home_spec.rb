require 'rails_helper'

describe 'Showing the home page' do
  before { visit root_path }

  it 'displays a welcome message' do
    within 'main' do
      expect(page).to have_content 'Accessibility Developer Guide'
    end
  end
end
