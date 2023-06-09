require 'rails_helper'

RSpec.describe 'Product card details' do
  before do
    mock_json_response(
      url: 'https://test/fixtures/test-articles-v4.json',
      local_file: 'products.json'
    )
  end

  def find_card(product_id:)
    visit '/products'
    page.find(".product-card[data-product-id=#{product_id}]")
  end

  # NOTE: these tests are largely identical at the moment, except for the product ID and the
  # relevant data. As the card UI develops, we may provide instances in the JSON with examples
  # of differences between the cards, and then we can add tests for those differences.
  context 'with the first product' do
    it 'includes the title, user name, description, and image' do
      card = find_card(product_id: 1001)

      expect(card).to have_selector('.title', text: 'Air Freshener')
      expect(card).to have_selector('.offerer', text: 'Lloyd is offering')
      expect(card).to have_selector('.description', text: 'This is a description of the air freshener')
      expect(card).to have_selector('img[src="/test/photo/1001_medium.gif"]')
    end
  end

  context 'with the second product' do
    it 'includes the title, user name, description, and image' do
      card = find_card(product_id: 1002)

      expect(card).to have_selector('.title', text: 'Printer Cartridges')
      expect(card).to have_selector('.offerer', text: 'Marti is offering')
      expect(card).to have_selector('.description', text: 'This is a description of the printer cartridges')
      expect(card).to have_selector('img[src="/test/photo/1002_medium.gif"]')
    end
  end

  context 'with the third product' do
    it 'includes the title, user name, description, and placeholder' do
      card = find_card(product_id: 1003)

      expect(card).to have_selector('.title', text: 'Waterproof jacket')
      expect(card).to have_selector('.offerer', text: 'Naomi is offering')
      expect(card).to have_selector('.description', text: 'This is a description of the waterproof jacket')
      expect(card).to have_selector('div.no-image', text: 'No image')
    end
  end

  describe 'Like counter display' do
    it 'shows 0 when there are no likes' do
      card = find_card(product_id: 1001)

      expect(card).to have_selector('.likes-count', text: '0')
    end

    it 'shows 1 when there is 1 like' do
      create(:like, article_id: 1001)

      card = find_card(product_id: 1001)

      expect(card).to have_selector('.likes-count', text: '1')
    end

    it 'correctly delimits large numbers of likes' do
      allow(Like).to receive(:all_counts).and_return(1001 => 1_000_000)

      card = find_card(product_id: 1001)

      expect(card).to have_selector('.likes-count', text: '1,000,000')
    end
  end
end
