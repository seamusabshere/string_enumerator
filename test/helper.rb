require 'rubygems'
require 'bundler'
Bundler.setup
require 'test/unit'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'string_enumerator'
class Test::Unit::TestCase
end
