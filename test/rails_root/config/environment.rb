RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

# Load a global constant so the initializers can use them
require 'ostruct'
require 'yaml'
::GlobalConfig = OpenStruct.new(YAML.load_file("#{RAILS_ROOT}/config/global_config.yml")[RAILS_ENV])

class TestGemLocator < Rails::Plugin::Locator
  def plugins
    Rails::Plugin.new(File.join(File.dirname(__FILE__), *%w(.. .. ..)))
  end 
end

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.gem "will_paginate"
  config.gem "authlogic"
  config.gem "searchlogic"
  config.gem "bcrypt-ruby", :lib => "bcrypt", :version => ">=2.0.5"
  config.gem "friendly_id"
  config.gem "babelphish"
  config.gem "oauth"
  config.gem "oauth-plugin"
  config.gem 'muck-engine', :lib => 'muck_engine'
  config.gem 'muck-users', :lib => 'muck_users'
  config.plugin_locators << TestGemLocator

  #config.active_record.default_timezone = :utc
  config.time_zone = 'UTC'
end