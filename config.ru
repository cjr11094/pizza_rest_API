# config.ru
require File.expand_path('../config/environment', __FILE__)
run Rest::App.instance