require 'rails_helper'
require 'support/json_fixtures'

RSpec.describe 'Products page loading JSON' do
  include JsonFixtures

  before do
    driven_by(:rack_test)

    mock_json_response(
      url: 'https://test/fixtures/test-articles-v4.json',
      local_file: 'products.json'
    )
  end

  it 'includes an entry for each product' do
    visit '/products'

    expect(page).to have_selector('li', count: 3)
  end

  it 'displays the titles of all products', :aggregate_failures do
    visit '/products'

    # These strings are defined in the JSON fixture
    expect(page).to have_content('Air Freshener')
    expect(page).to have_content('Printer Cartridges')
    expect(page).to have_content('Waterproof jacket')
  end

  it 'marks each entry with a data attribute using its ID' do
    visit '/products'

    ids = page.all('li[data-product-id]')
              .pluck('data-product-id')

    expect(ids).to contain_exactly('1001', '1002', '1003')
  end
end
