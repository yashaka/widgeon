require 'rspec/expectations'
require 'capybara/rspec'

require 'widgeon'

require 'widgeon/page_factory'
include Widgeon::PageFactory

require 'resources/pages/order'
include TestApp

RSpec.configure do |c|
  Capybara.default_driver = :selenium
  Capybara.app_host = 'file://' + File.expand_path('.') + '/spec/resources/testapp/'
  Capybara.default_wait_time = 4
end