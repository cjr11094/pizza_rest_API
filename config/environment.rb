$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'models'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

Bundler.require :default, ENV['RACK_ENV']

require 'models'
require 'api'
require 'rest_app'