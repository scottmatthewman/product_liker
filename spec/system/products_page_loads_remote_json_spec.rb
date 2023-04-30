require 'rails_helper'

RSpec.describe 'Products page loading JSON' do
  before do
    driven_by(:rack_test)

    json_path = Rails.root.join('spec/fixtures/json/products.json')
    json_contents = File.read(json_path)

    stub_request(:get, /test-articles-v4.json/)
      .to_return(status: 200, body: json_contents, headers: { 'Content-Type' => 'application/json' })
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
