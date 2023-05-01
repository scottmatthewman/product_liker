require 'rails_helper'

RSpec.describe ProductsHelper do
  describe '#product_image' do
    let(:product) do
      {
        title: 'Test product',
        photos: [
          {
            files: {
              small: '/images/small/test-product.jpg',
              medium: '/images/medium/test-product.jpg',
              large: '/images/large/test-product.jpg'
            }
          }
        ]
      }
    end

    def build_node(html, selector: 'img')
      Capybara.string(html).first(selector)
    end

    it 'returns an image tag with the small image by default' do
      html = helper.product_image(product)
      node = build_node(html)

      expect(node[:src]).to eq('/images/small/test-product.jpg')
    end

    it 'returns an image tag with the medium image on request' do
      html = helper.product_image(product, size: :medium)
      node = build_node(html)

      expect(node[:src]).to eq('/images/medium/test-product.jpg')
    end

    it 'returns an image tag with the large image on request' do
      html = helper.product_image(product, size: :large)
      node = build_node(html)

      expect(node[:src]).to eq('/images/large/test-product.jpg')
    end

    it 'sets the width and height of the image', :aggregate_failures do
      html = helper.product_image(product)
      node = build_node(html)

      expect(node[:width]).to eq('80')
      expect(node[:height]).to eq('80')
    end

    it 'sets the alt text of the image' do
      html = helper.product_image(product)
      node = build_node(html)

      expect(node[:alt]).to eq('User-supplied photo of Test product')
    end

    it 'returns a no-image div if no image is available' do
      product[:photos][0][:files] = {}

      expect(helper.product_image(product)).to eq(
        '<div class="no-image">No image</div>'
      )
    end
  end
end
