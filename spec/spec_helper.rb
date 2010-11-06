require 'rubygems'
require 'bundler/setup'
require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'textractor'

def fixture_path(path)
  File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', path))
end

Spec::Runner.configure do |config|

end
