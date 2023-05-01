module ProductsHelper
  def product_image(product, size: :small)
    img_src = product.dig(:photos, 0, :files, size)
    if img_src
      image_tag(img_src, size: '80x80', alt: "User-supplied photo of #{product[:title]}")
    else
      content_tag(:div, 'No image', class: 'no-image')
    end
  end
end
