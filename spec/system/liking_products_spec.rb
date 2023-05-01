require 'rails_helper'
require 'support/json_fixtures'

RSpec.describe 'Liking a product' do
  include JsonFixtures

  it 'increments the like count from 0 to 1 when the product has no previous likes', :aggregate_failures, :js do
    mock_json_response(
      url: 'https://test/fixtures/test-articles-v4.json',
      local_file: 'products.json'
    )

    visit '/products'

    expect(page).to have_selector('li[data-product-id="1001"] span.likes-count', text: '0')

    within('li[data-product-id="1001"]') do
      click_button class: 'like-button'
    end

    expect(page).to have_selector('li[data-product-id="1001"] span.likes-count', text: '1')
  end

  it 'increments the like count from 1 to 2 when the product has 1 previous like', :aggregate_failures, :js do
    create(:like, article_id: 1001)

    mock_json_response(
      url: 'https://test/fixtures/test-articles-v4.json',
      local_file: 'products.json'
    )

    visit '/products'

    expect(page).to have_selector('li[data-product-id="1001"] span.likes-count', text: '1')

    within('li[data-product-id="1001"]') do
      click_button class: 'like-button'
    end

    expect(page).to have_selector('li[data-product-id="1001"] span.likes-count', text: '2')
  end
end
