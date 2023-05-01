require 'json_utilities'

class ProductsController < ApplicationController
  def index
    @products = JsonUtilities.json_from_url(:articles)
  end
end
