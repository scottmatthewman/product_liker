require 'support/json_fixtures'

RSpec.configure do |config|
  config.include JsonFixtures, type: :system
end
