require 'webdrivers/chromedriver'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by(:rack_test)
  end

  config.before(:each, js: true, type: :system) do
    # Use :selenium_chrome to see the browser during tests
    driven_by(:selenium_chrome_headless)
  end
end
