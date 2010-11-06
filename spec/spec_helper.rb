$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'textractor'
require 'spec'
require 'spec/autorun'

def fixture_path(path)
  File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', path))
end

Spec::Runner.configure do |config|

end
