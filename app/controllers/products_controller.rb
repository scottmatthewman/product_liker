require 'net/http'
require 'json'
class ProductsController < ApplicationController
  def index
    url = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @products = JSON.parse(response, symbolize_names: true)
  end
end
