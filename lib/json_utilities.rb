require 'net/http'

module JsonUtilities
  class << self
    def json_from_url(url_or_symbol)
      uri = URI(actual_url(url_or_symbol))
      response = Net::HTTP.get(uri)
      JSON.parse(response, symbolize_names: true)
    end

    private

    def actual_url(url_or_symbol)
      case url_or_symbol
      when Symbol
        Rails.configuration.json_path.fetch(url_or_symbol)
      else
        url_or_symbol.to_s
      end
    end
  end
end
