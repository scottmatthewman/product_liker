module JsonFixtures
  def mock_json_response(url:, local_file:)
    stub_request(:get, url)
      .to_return(status: 200,
                 body: Rails.root.join('spec/fixtures/json', local_file).read,
                 headers: { 'Content-Type' => 'application/json' })
  end
end
