require File.join(File.dirname(__FILE__), '..', '..', 'app')
require 'capybara'
require 'capybara/cucumber'


Capybara.app = Application
