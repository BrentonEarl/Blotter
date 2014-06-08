# spec/spec_helper.rb
require 'rubygems'
require 'rack/test'
require 'capybara/dsl'

require File.expand_path '/../app.rb', __FILE__

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.include Capybara
end

module RSpecMixin
  include Rack::Test::Methods
  def app() Application end
end

# For RSpec 2.x
RSpec.configure { |c| c.include RSpecMixin }
# If you use RSpec 1.x you should use this instead:
Spec::Runner.configure { |c| c.include RSpecMixin }