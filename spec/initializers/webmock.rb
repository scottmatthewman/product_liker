require 'webmock/rspec'

allowed_sites = [
  'chromedriver.storage.googleapis.com'
]

WebMock.disable_net_connect!(allow_localhost: true, allow: allowed_sites)
