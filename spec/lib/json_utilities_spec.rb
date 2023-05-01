# frozen_string_literal: true

require 'rails_helper'
require 'support/json_fixtures'

require 'json_utilities'

RSpec.describe JsonUtilities do
  include JsonFixtures

  describe '.json_from_url' do
    it 'returns the parsed JSON when supplied with a URL string' do
      json_url = 'http://example.com/test.json'
      json_contents = '{"foo": "bar"}'

      stub_request(:get, json_url)
        .to_return(status: 200, body: json_contents, headers: { 'Content-Type' => 'application/json' })

      expect(described_class.json_from_url(json_url)).to eq(foo: 'bar')
    end

    context 'when supplied with a symbol' do
      it 'accepts a symbol as the URL' do
        mock_json_response(
          url: 'https://test/fixtures/test-articles-v4.json',
          local_file: 'products.json'
        )

        expect(described_class.json_from_url(:articles)).to be_an(Array)
      end

      it 'throws an error when the symbol does not exist in the configuration file' do
        expect { described_class.json_from_url(:not_a_real_symbol) }.to raise_error(KeyError)
      end
    end
  end
end
