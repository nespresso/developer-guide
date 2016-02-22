require 'rails_helper'

describe 'Showing the home page' do
  before { visit root_path }

  it 'displays a welcome message' do
    expect(page).to have_breadcrumbs 'ADG', 'Welcome to the...'
    expect(page).to have_headline 'Welcome to the Accessibility Developer Guide (ADG)'
  end
end
