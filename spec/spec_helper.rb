$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'textractor'

def fixture_path(path)
  File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', path))
end

RSpec.configure do |config|

end
